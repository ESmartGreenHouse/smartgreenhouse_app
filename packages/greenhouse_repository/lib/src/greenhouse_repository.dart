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
              'id': device['id'] as String,
              'name': device['name'] as String,
              'notes': device['notes'] as String,
              'owner_uid': (await authenticationRepository.currentUser).id,
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

  /// Returns the measured values of a sensor of a particle in the last day.
  Future<List<Measurement>> getRecentMeasurement({@required Particle particle, @required Sensor sensor, @required DateTime date}) async {
    try {
      final minTimestamp = Timestamp.fromDate(date.subtract(Duration(days: 1)));
      final maxTimestamp = Timestamp.fromDate(date.add(Duration(days: 1)));

      final snapshot = await firestore.collection('data')
        .where('particle_id', isEqualTo: particle.id)
        .where('sensor', isEqualTo: sensor.name)
        .where('min_timestamp', isGreaterThan: minTimestamp)
        .where('min_timestamp', isLessThan: maxTimestamp)
        .get();

      final List<Measurement> result = [];
      for (final doc in snapshot.docs) {
        for (final value  in doc.data()['values']) {
          result.add(Measurement(
            timestamp: (value['timestamp'] as Timestamp).toDate(),
            value: value['value'] as double,
          ));
        }
      }

      return result;
    } catch(e) {
      print(e);
      return null;
    }
  }
}
