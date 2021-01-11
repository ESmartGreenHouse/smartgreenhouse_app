import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartgreenhouse_app/sensor_values/sensor_values.dart';

class SensorValuesList extends StatelessWidget {
  const SensorValuesList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<SensorValuesCubit, SensorValuesState>(
      builder: (context, state) {
        print(state);
        if (state is SensorValuesLoadSuccess) {
          return ListView.builder(
            itemCount: state.sensors.length,
            itemBuilder: (context, index) => ListTile(
              title: Text('${state.sensors.elementAt(index).value ?? '-'}'),
              subtitle: Text(state.sensors.elementAt(index).name),
            ),
          );
        }
        return ListTile(
          title: Text('TEST'),
        );
      },
    );
  }
}
