import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartgreenhouse_app/reports/cubit/reports_cubit.dart';
import 'package:smartgreenhouse_app/reports_picker/reports_picker.dart';
import 'package:smartgreenhouse_app/theme.dart';

class ReportsPicker extends StatelessWidget {
  const ReportsPicker({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReportsPickerCubit(),
      child: BlocListener<ReportsPickerCubit, ReportsPickerState>(
        listener: (context, state) {
          if (state.isValid) context.bloc<ReportsCubit>().load(state.particle, state.sensor, state.dateTime, state.calculateAverage);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text('Measurement', style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('Select a sensor and time to display its measurement'),
              leading: BlocBuilder<ReportsPickerCubit, ReportsPickerState>(
                builder: (context, state) {
                  if (state.isValid) {
                    return Icon(Icons.check_circle_outline, color: GreenHouseColors.green);
                  }
                  return Icon(Icons.error_outline, color: GreenHouseColors.orange);
                },
              ),
            ),
            Divider(),
            ReportsPickerDate(),
            ReportsPickerTime(),
            Divider(),
            BlocBuilder<ReportsPickerCubit, ReportsPickerState>(
              builder: (context, state) {
                return ListTile(
                  leading: Icon(state.calculateAverage ? Icons.check_box : Icons.check_box_outline_blank, color: GreenHouseColors.green),
                  title: Text('Calculate minute average'),
                  onTap: () => context.bloc<ReportsPickerCubit>().toggleAverage(),
                );
              },
            ),
            Divider(),
            BlocBuilder<ReportsPickerCubit, ReportsPickerState>(
              builder: (context, state) {
                final isSelected = state.particle != null && state.sensor != null;
                return ListTile(
                  title: Text('Particle and Sensor'),
                  leading: Icon(Icons.memory, color: isSelected ? GreenHouseColors.green : GreenHouseColors.orange),
                  subtitle: Text(isSelected ? '[${state.particle.name}] ${state.sensor.name}' : 'Select Sensor and Particle'),
                );
              },
            ),
            ReportsPickerSensor(),
          ],
        ),
      ),
    );
  }
}
