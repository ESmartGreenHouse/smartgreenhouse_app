import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greenhouse_repository/greenhouse_repository.dart';
import 'package:smartgreenhouse_app/common/responsive_grid.dart';
import 'package:smartgreenhouse_app/tasks/tasks.dart';
import 'package:smartgreenhouse_app/theme.dart';

class TasksGrid extends StatelessWidget {
  const TasksGrid({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: BlocBuilder<TasksCubit, TasksState>(
        builder: (context, state) {
          if (state is TasksLoadSuccess) {
            return ResponsiveGrid(
              children: List.generate(state.tasks.length, (index) {
                return Card(
                  margin: EdgeInsets.all(10.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        ListTile(
                          title: Text('Task $index', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Divider(),
                        ...state.tasks[index].rules.map((e) => ListTile(
                          title: Text('${e.sensor.name} ${e.ruleType.string()} ${e.thresholdType.string()} ${e.threshold}'),
                          subtitle: Text('Rule'),
                          leading: e.thresholdType.icon(e.ruleType.color()),
                          trailing: IconButton(
                            icon: Icon(Icons.edit, color: GreenHouseColors.black),
                            onPressed: () async {
                              final result = await showDialog<Rule>(context: context, builder: (_) => RuleThresholdDialog(rule: e));
                              print(result);
                              context.bloc<TasksCubit>().updateRule(result);
                            },
                          ),
                        )).toList(),
                        Divider(),
                        ListTile(
                          title: Text('${state.tasks[index].actuator.name} ${state.tasks[index].action.string()}'),
                          subtitle: Text('Action'),
                          leading: state.tasks[index].action.icon(),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            );
          }
          if (state is TasksLoadInProgress) {
            return LinearProgressIndicator();
          }
          if (state is TasksLoadFailure) {
            return ListTile(
              title: Text(state.message),
              leading: Icon(Icons.error, color: GreenHouseColors.orange),
            );
          }
          return ListTile(
            title: Text('Unknown state'),
            leading: Icon(Icons.error, color: GreenHouseColors.orange),
          );
        }
      ),
    );
  }
}
