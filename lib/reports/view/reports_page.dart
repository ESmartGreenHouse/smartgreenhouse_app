import 'package:flutter/material.dart';
import 'package:responsive_scaffold/templates/layout/scaffold.dart';
import 'package:smartgreenhouse_app/logout/logout.dart';
import 'package:smartgreenhouse_app/menu/menu.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({Key key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => ReportsPage());
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaffold(
      title: Text('Reports'),
      drawer: AppDrawer(),
      trailing: LogoutButton(),
      body: Center(child: Text('Reports')),
    );
  }
}
