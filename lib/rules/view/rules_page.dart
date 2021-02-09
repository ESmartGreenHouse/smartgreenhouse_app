import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartgreenhouse_app/menu/menu.dart';
import 'package:smartgreenhouse_app/rules/rules.dart';

class RulesPage extends StatelessWidget {
  static Route route() {
    return PageRouteBuilder<MaterialPageRoute<void>>(
      pageBuilder: (_, __, ___) => RulesPage(),
      transitionDuration: Duration(seconds: 0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rules'),
        actions: [
          IconButton(
            tooltip: 'Refresh Tresholds',
            icon: Icon(Icons.refresh),
            onPressed: () {
              context.bloc<RulesCubit>().reload();
            }
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: RulesList(),
    );
  }
}
