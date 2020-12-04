import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartgreenhouse_app/sensors/sensors.dart';
import 'package:smartgreenhouse_app/theme.dart';

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
            itemBuilder: (context, index) {
              final sensor = state.sensors.elementAt(index);
              return ListTile(
                title: Text(sensor.name),
                subtitle: Text(sensor.type.toString()),
                leading: IconButton(
                  icon: Icon(sensor.name == state.selected?.name ? Icons.radio_button_checked : Icons.radio_button_unchecked, color: GreenHouseColors.green),
                  onPressed: () => context.bloc<SensorsCubit>().select(sensor),
                ),
                onTap: () => context.bloc<SensorsCubit>().select(sensor),
              );
            },
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
