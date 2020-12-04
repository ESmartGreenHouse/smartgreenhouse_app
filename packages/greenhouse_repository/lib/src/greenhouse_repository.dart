import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:greenhouse_repository/greenhouse_repository.dart';

class GreenhouseRepository {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  static const deviceId = '5e39bc905230ef803dbf89c733d1350e0de664991c1de6c62514a16fb78a96f8';

  Future<void> test() async {
    CollectionReference devices = firestore.collection('devices');
    final snapshot = await devices.doc('5e39bc905230ef803dbf89c733d1350e0de664991c1de6c62514a16fb78a96f8').get();
    Map<String, dynamic> data = snapshot.data();
    print(data);

    final sensor = await devices.doc('5e39bc905230ef803dbf89c733d1350e0de664991c1de6c62514a16fb78a96f8').collection('sensors').get();
    for(var doc in sensor.docs) {
      print(doc.id);
      print(doc.data());
      var values = await devices.doc('5e39bc905230ef803dbf89c733d1350e0de664991c1de6c62514a16fb78a96f8').collection('sensors').doc(doc.id).collection('Values').get();
      print(values.docs.map((e) => e.data()));
    }
  }

  Future<List<Sensor>> getSensors() async {
    try {
      final result = await firestore.collection('devices').doc(deviceId).collection('sensors').get();
      return result.docs.map<Sensor>((e) => Sensor(name: e.id)).toList();
    } catch(e) {
      print(e);
      return null;
    }
  }

}
