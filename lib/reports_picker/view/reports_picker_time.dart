import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartgreenhouse_app/reports_picker/reports_picker.dart';
import 'package:smartgreenhouse_app/theme.dart';

class ReportsPickerTime extends StatelessWidget {
  const ReportsPickerTime({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: BlocBuilder<ReportsPickerCubit, ReportsPickerState>(
        builder: (context, state) {
          if (state.dateTime != null) {
            final time = TimeOfDay.fromDateTime(state.dateTime);
            return Text('${time.hour}:${time.minute}');
          } else {
            return Text('Please select date and time');
          }
        },
      ),
      leading: Icon(Icons.schedule, color: GreenHouseColors.green),
      onTap: () async {
        final time = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );
        if (time != null) context.bloc<ReportsPickerCubit>().time(time);
      },
    );
  }
}
