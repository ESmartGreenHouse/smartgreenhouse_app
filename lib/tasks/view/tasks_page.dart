import 'package:flutter/material.dart';
import 'package:responsive_scaffold/templates/layout/scaffold.dart';
import 'package:smartgreenhouse_app/logout/logout.dart';
import 'package:smartgreenhouse_app/menu/menu.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({Key key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => TasksPage());
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaffold(
      title: Text('Tasks'),
      drawer: AppDrawer(),
      trailing: LogoutButton(),
      body: Center(child: Text('Tasks')),
    );
  }
}
