import 'package:cloud_firestore/cloud_firestore.dart';

class GreenhouseRepository {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

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

}
