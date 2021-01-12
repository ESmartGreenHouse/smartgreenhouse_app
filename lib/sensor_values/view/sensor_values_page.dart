import 'package:flutter/material.dart';
import 'package:smartgreenhouse_app/logout/logout.dart';
import 'package:smartgreenhouse_app/sensor_values/view/sensor_values_indoor.dart';
import 'package:smartgreenhouse_app/sensor_values/view/sensor_values_outdoor.dart';
import 'package:smartgreenhouse_app/theme.dart';

class SensorValuesPage extends StatefulWidget {
  SensorValuesPage({Key key}) : super(key: key);

  @override
  _SensorValuesPageState createState() => _SensorValuesPageState();
}

class _SensorValuesPageState extends State<SensorValuesPage> {
  int _index = 0;

  var _widgets = [
    SensorValuesIndoor(),
    SensorValuesOutdoor(),
  ];

  void _onTabSelected(int index) {
    setState(() {
      _index =index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SmartGreenHouse'),
        actions: [
          LogoutButton(),
        ],
      ),
      body: _widgets.elementAt(_index),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Indoor'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.nature),
            label: 'Outdoor'
          ),
        ],
        currentIndex: _index,
        selectedItemColor: GreenHouseColors.green,
        onTap: _onTabSelected,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: GreenHouseColors.green,
              ),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
              },
            ),
          ],
        ),
      ),
    );
  }
}