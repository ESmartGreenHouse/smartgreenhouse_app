import 'package:flutter/material.dart';
import 'package:smartgreenhouse_app/menu/menu.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({Key key}) : super(key: key);

  static Route route() {
    return PageRouteBuilder<MaterialPageRoute<void>>(
      pageBuilder: (_, __, ___) => TasksPage(),
      transitionDuration: Duration(seconds: 0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tasks')),
      drawer: AppDrawer(),
      body: Center(child: Text('Tasks')),
    );
  }
}
