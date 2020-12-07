import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smartgreenhouse_app/alerts/alerts.dart';
import 'package:smartgreenhouse_app/home/home.dart';
import 'package:smartgreenhouse_app/particles/particles.dart';
import 'package:smartgreenhouse_app/reports/reports.dart';
import 'package:smartgreenhouse_app/tasks/tasks.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: FaIcon(FontAwesomeIcons.home),
          title: Text('Home'),
          onTap: () => Navigator.of(context).pushAndRemoveUntil<void>(HomePage.route(), (route) => false),
        ),
        ListTile(
          leading: FaIcon(FontAwesomeIcons.microchip),
          title: Text('Particles'),
          onTap: () => Navigator.of(context).pushAndRemoveUntil<void>(ParticlesPage.route(), (route) => false),
        ),
        ListTile(
          leading: FaIcon(FontAwesomeIcons.clipboardList),
          title: Text('Reports'),
          onTap: () => Navigator.of(context).pushAndRemoveUntil<void>(ReportsPage.route(), (route) => false),
        ),
        ListTile(
          leading: FaIcon(FontAwesomeIcons.cogs),
          title: Text('Tasks'),
          onTap: () => Navigator.of(context).pushAndRemoveUntil<void>(TasksPage.route(), (route) => false),
        ),
        ListTile(
          leading: FaIcon(FontAwesomeIcons.bell),
          title: Text('Alerts'),
          onTap: () => Navigator.of(context).pushAndRemoveUntil<void>(AlertsPage.route(), (route) => false),
        ),
      ],
    );
  }
}
