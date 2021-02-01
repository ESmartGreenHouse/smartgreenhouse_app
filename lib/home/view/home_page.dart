import 'package:flutter/material.dart';
import 'package:smartgreenhouse_app/sensor_values/sensor_values.dart';

class HomePage extends StatelessWidget {
  static Route route() {
    return PageRouteBuilder<MaterialPageRoute<void>>(
      pageBuilder: (_, __, ___) => HomePage(),
      transitionDuration: Duration(seconds: 0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SensorValuesPage();
  }
}
