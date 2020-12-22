import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:greenhouse_repository/greenhouse_repository.dart';
import 'package:meta/meta.dart';

class GreenhouseRepository {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<Particle>> getParticles(String uid) async {

    try {
      final result = await firestore.collection('particles')
        .where('read_uid', arrayContains: uid)
        .get();

      return result.docs.map<Particle>((d) => Particle(
        id: d.data()['particle_id'] as String,
        name: d.data()['particle_name'] as String,
        description: d.data()['particle_description'] as String,
        ownerUid: d.data()['owner_uid'] as String,
        sensors: (d.data()['sensors'])?.map<Sensor>((e) => Sensor(name: e.toString()))?.toList() ?? <Sensor>[]
      )).toList();
    } catch(e) {
      print(e);
      return null;
    }
  }

  Future<bool> addParticle(Particle particle) async {
    try {
      await firestore.collection('particles').doc(particle.id).set({
        'particle_id': particle.id,
        'particle_name': particle.name,
        'particle_description ': particle.description ?? '',
        'owner_uid': particle.ownerUid,
      });
      return true;
    } catch(e) {
      print(e);
      return false;
    }
  }

  /// Returns the measured values of a sensor of a particle in the last day.
  Future<List<Measurement>> getRecentMeasurement({@required Particle particle, @required Sensor sensor, @required DateTime date}) async {
    try {
      final snapshot = await firestore.collection('data')
        .where('particle_id', isEqualTo: particle.id)
        .where('sensor', isEqualTo: sensor.name)
        .where('min_timestamp', isGreaterThan: Timestamp.fromDate(date.subtract(Duration(days: 1))))
        .where('min_timestamp', isLessThan: Timestamp.fromDate(date))
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
