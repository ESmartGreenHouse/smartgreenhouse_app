import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greenhouse_repository/greenhouse_repository.dart';
import 'package:responsive_scaffold/templates/layout/scaffold.dart';
import 'package:smartgreenhouse_app/logout/logout.dart';
import 'package:smartgreenhouse_app/menu/menu.dart';
import 'package:smartgreenhouse_app/tasks/tasks.dart';

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
    return ResponsiveScaffold(
      title: Text('Tasks'),
      drawer: AppDrawer(),
      trailing: LogoutButton(),
      body: BlocProvider(
        create: (context) => TasksCubit(
          greenhouseRepository: context.repository<GreenhouseRepository>()
        )..load(),
        child: TasksGrid(),
      ),
    );
  }
}
