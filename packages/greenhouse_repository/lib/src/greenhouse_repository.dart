import 'package:authentication_repository/authentication_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:greenhouse_repository/greenhouse_repository.dart';
import 'package:meta/meta.dart';

class GreenhouseRepository {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final AuthenticationRepository authenticationRepository;

  GreenhouseRepository({@required this.authenticationRepository}) : assert(authenticationRepository != null);

  Future<void> syncParticles() async {
    final user = await authenticationRepository.currentUser;

    if (user == User.empty) return;

    if (!user.isCloudLinked) {
      try {
        final particles = await firestore.collection('particles').where('owner_uid', isEqualTo: user.id).get();
        for (final particle in particles.docs) {
          await firestore.collection('particles').doc(particle.id).delete();
        }
      } catch(e) {
        print(e);
      }
    }

    if (user.isCloudLinked) {
      try {
        final response = await Dio().get<List<dynamic>>('https://api.particle.io/v1/devices',
          options: Options(headers: { 'Authorization': 'Bearer ${await authenticationRepository.token}'})
        );

        if (response.statusCode == 200) {
          for (final device in response.data) {
            await firestore.collection('particles').doc(device['id'] as String).set({
              'owner_uid': (await authenticationRepository.currentUser).id,
              'id': device['id'] as String,
              'name': device['name'] as String,
              'notes': device['notes'] as String,
              'sensors': (device['variables'] as Map<String, dynamic>)
                .keys
                .where((v) => v.contains('sensor_'))
                .map((v) => v.split('_')[1])
                .toList(),
              'actuators': (device['variables'] as Map<String, dynamic>)
                .keys
                .where((v) => v.contains('state_'))
                .map((v) => v.split('_')[1])
                .toList(),
            }, SetOptions(merge: true));
          }
        }

      } on DioError catch(e) {
        print(e);
      } catch(e) {
        print(e);
      }
    }
  }

  Future<List<Particle>> getParticles() async {
    try {
      final ownedParticles = (await firestore.collection('particles')
        .where('owner_uid', isEqualTo: (await authenticationRepository.currentUser).id)
        .get())
        .docs
        .map((d) => Particle(
          id: d.get('id') as String,
          name: d.get('name') as String,
          notes: d.get('notes') as String ?? '',
          isShared: d.data().containsKey('shared') ? d.get('shared') as bool ?? false : false,
          isOwned: true,
          sensors: (d.get('sensors') as List<dynamic>)?.map((s) => Sensor(name: s.toString()))?.toList() ?? [],
          actuators: (d.get('actuators') as List<dynamic>)?.map((s) => Actuator(name: s.toString()))?.toList() ?? [],
        ))
        .toList();

      final sharedParticles = (await firestore.collection('particles')
        .where('owner_uid', isNotEqualTo: (await authenticationRepository.currentUser).id)
        .where('shared', isEqualTo: true)
        .get())
        .docs
        .map((d) => Particle(
          id: d.get('id') as String,
          name: d.get('name') as String,
          notes: d.get('notes') as String ?? '',
          isShared: d.data().containsKey('shared') ? d.get('shared') as bool ?? false : false,
          isOwned: false,
          sensors: (d.get('sensors') as List<dynamic>)?.map((s) => Sensor(name: s.toString()))?.toList() ?? [],
          actuators: (d.get('actuators') as List<dynamic>)?.map((s) => Actuator(name: s.toString()))?.toList() ?? [],
        ))
        .toList();

        return [...ownedParticles, ...sharedParticles];

    } on DioError catch(e) {
      print(e);
    } catch(e) {
      print(e);
    }
  }

  Future<void> shareParticleData(Particle particle) async {
    try {
      await firestore.collection('particles').doc(particle.id).set({'shared': particle.isShared}, SetOptions(merge: true));
    } catch(e) {
      print(e);
    }
  }

  Future<void> renameParticle(Particle particle) async {
    try {
      await Dio().put('https://api.particle.io/v1/devices/${particle.id}', data: {
        'name': particle.name,
      }, options: Options(headers: { 'Authorization': 'Bearer ${await authenticationRepository.token}'}));
    } catch(e) {
      print(e);
    }
  }

  Future<void> changeParticleNotes(Particle particle) async {
    try {
      await Dio().put('https://api.particle.io/v1/devices/${particle.id}', data: {
        'notes': particle.notes,
      }, options: Options(headers: { 'Authorization': 'Bearer ${await authenticationRepository.token}'}));
    } catch(e) {
      print(e);
    }
  }

  Stream<Sensor> getSensorValuesOfParticle(Particle particle) async* {
    for (final sensor in particle.sensors) {
      try {
        final response = await Dio().get('https://api.particle.io/v1/devices/${particle.id}/sensor_${sensor.name}',
          options: Options(headers: { 'Authorization': 'Bearer ${await authenticationRepository.token}'}),
        );
        if (response.statusCode == 200) {
          yield sensor.copyWith(value: response.data['result'] as double);
        } else {
          // TODO
        }
      } catch(e) {
        print(e);
      }
    }
  }

  Stream<Actuator> getActuatorValuesOfParticle(Particle particle) async* {
    for (final actuator in particle.actuators) {
      try {
        final response = await Dio().get('https://api.particle.io/v1/devices/${particle.id}/state_${actuator.name}',
          options: Options(headers: { 'Authorization': 'Bearer ${await authenticationRepository.token}'}),
        );
        if (response.statusCode == 200) {
          yield actuator.copyWith(value: response.data['result'] as bool);
        } else {
          // TODO
        }
      } catch(e) {
        print(e);
      }
    }
  }

  /// Returns the measured values of a sensor of a particle in the last hour.
  Future<List<Measurement>> getRecentMeasurement({
    @required Particle particle,
    @required Sensor sensor,
    @required DateTime date,
    bool calculateAverage = false,
  }) async {
    try {
      final minTimestamp = Timestamp.fromDate(date.subtract(Duration(hours: 1)));
      final maxTimestamp = Timestamp.fromDate(date);

      final snapshot = await firestore.collection('data')
        .where('particle_id', isEqualTo: particle.id)
        .where('sensor', isEqualTo: sensor.name)
        .where('min_timestamp', isGreaterThan: minTimestamp)
        .where('min_timestamp', isLessThan: maxTimestamp)
        .get();

      final List<Measurement> result = [];
      for (final doc in snapshot.docs) {
        final values = doc.get('values') as List<dynamic>;

        if (calculateAverage) {
          result.add(Measurement(
            timestamp: (doc.get('min_timestamp') as Timestamp).toDate(),
            value: values.map((v) => v as double).toList().reduce((value, element) => value += element) / values.length,
          ));
        } else {
          for (var i = 0; i < values.length; i++) {
            result.add(Measurement(
              timestamp: (doc.get('min_timestamp') as Timestamp).toDate().add(Duration(seconds: (60 / values.length * i).round())),
              value: values.elementAt(i),
            ));
          }
        }
      }

      return result;
    } catch(e) {
      print(e);
      return null;
    }
  }
}
