import 'package:flutter/material.dart';
import 'package:responsive_scaffold/templates/layout/scaffold.dart';
import 'package:smartgreenhouse_app/logout/logout.dart';
import 'package:smartgreenhouse_app/menu/menu.dart';

class DevicesPage extends StatelessWidget {
  const DevicesPage({Key key}) : super(key: key);

  static Route route() {
    return PageRouteBuilder<MaterialPageRoute<void>>(
      pageBuilder: (_, __, ___) => DevicesPage(),
      transitionDuration: Duration(seconds: 0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaffold(
      title: Text('Devices'),
      drawer: AppDrawer(),
      trailing: LogoutButton(),
      body: Center(child: Text('Devices')),
    );
  }
}
