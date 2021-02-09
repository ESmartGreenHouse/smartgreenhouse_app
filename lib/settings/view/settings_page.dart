import 'package:flutter/material.dart';
import 'package:smartgreenhouse_app/menu/menu.dart';
import 'package:smartgreenhouse_app/particle_cloud/particle_cloud.dart';

class SettingsPage extends StatelessWidget {
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
