import 'package:flutter/material.dart';
import 'package:responsive_scaffold/templates/layout/scaffold.dart';
import 'package:smartgreenhouse_app/logout/logout.dart';
import 'package:smartgreenhouse_app/menu/menu.dart';

class AlertsPage extends StatelessWidget {
  const AlertsPage({Key key}) : super(key: key);

  static Route route() {
    return PageRouteBuilder<MaterialPageRoute<void>>(
      pageBuilder: (_, __, ___) => AlertsPage(),
      transitionDuration: Duration(seconds: 0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaffold(
      title: Text('Alerts'),
      drawer: AppDrawer(),
      trailing: LogoutButton(),
      body: Center(child: Text('Alerts')),
    );
  }
}
