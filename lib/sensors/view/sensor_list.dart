import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartgreenhouse_app/sensors/sensors.dart';

class SensorList extends StatelessWidget {
  const SensorList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SensorsCubit, SensorsState>(
      builder: (context, state) {
        if (state is SensorsLoadInProgress) {
          return ListTile(
            title: Text('Loading'),
            leading: CircularProgressIndicator(),
          );
        }
        if (state is SensorsLoadSuccess) {
          return ListView.builder(
            itemCount: state.sensors.length,
            itemBuilder: (context, index) => ListTile(
              title: Text(state.sensors.elementAt(index).name),
              subtitle: Text(state.sensors.elementAt(index).type.toString()),
            ),
          );
        }
        if (state is SensorsLoadFailure) {
          return ListTile(
            title: Text('Load Failure'),
            subtitle: Text(state.message),
          );
        }
        return ListTile(
          title: Text('Unknown state'),
          subtitle: Text('SensorsCubit'),
        );
      },
    );
  }
}
