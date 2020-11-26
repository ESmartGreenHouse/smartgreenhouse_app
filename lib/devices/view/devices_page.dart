import 'package:flutter/material.dart';
import 'package:responsive_scaffold/templates/layout/scaffold.dart';
import 'package:smartgreenhouse_app/logout/logout.dart';
import 'package:smartgreenhouse_app/menu/menu.dart';

class DevicesPage extends StatelessWidget {
  const DevicesPage({Key key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => DevicesPage());
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
