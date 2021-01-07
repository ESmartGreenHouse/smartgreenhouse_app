import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartgreenhouse_app/reports_picker/reports_picker.dart';
import 'package:smartgreenhouse_app/theme.dart';

class ReportsPickerDate extends StatelessWidget {
  const ReportsPickerDate({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: BlocBuilder<ReportsPickerCubit, ReportsPickerState>(
        builder: (context, state) {
          if (state.dateTime != null) {
            return Text('${state.dateTime.year}-${state.dateTime.month}-${state.dateTime.day}');
          } else {
            return Text('Please select a date');
          }
        },
      ),
      leading: Icon(Icons.calendar_today, color: GreenHouseColors.green),
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          firstDate: DateTime.now().subtract(Duration(days: 30)),
          lastDate: DateTime.now(),
          initialDate: DateTime.now(),
        );
        if (date != null) context.bloc<ReportsPickerCubit>().date(date);
      },
    );
  }
}
