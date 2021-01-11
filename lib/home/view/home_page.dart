import 'package:flutter/material.dart';
import 'package:responsive_scaffold/templates/layout/scaffold.dart';
import 'package:smartgreenhouse_app/logout/logout.dart';
import 'package:smartgreenhouse_app/menu/menu.dart';
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
    return ResponsiveScaffold(
      title: Text('Home'),
      drawer: AppDrawer(),
      endIcon: Icons.help,
      trailing: LogoutButton(),
      body: SensorValuesList(),
    );
  }
}
