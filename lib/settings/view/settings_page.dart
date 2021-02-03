import 'package:flutter/material.dart';
import 'package:smartgreenhouse_app/menu/menu.dart';
import 'package:smartgreenhouse_app/particle_cloud/particle_cloud.dart';

class SettingsPage extends StatelessWidget {
  static Route route() {
    return PageRouteBuilder<MaterialPageRoute<void>>(
      pageBuilder: (_, __, ___) => SettingsPage(),
      transitionDuration: Duration(seconds: 0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      drawer: AppDrawer(),
      body: ListView(
        children: [
          ParticleCloudTile(),
        ],
      ),
    );
  }
}
