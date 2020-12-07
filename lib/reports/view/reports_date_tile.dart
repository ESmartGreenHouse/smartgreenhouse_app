import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartgreenhouse_app/reports/reports.dart';
import 'package:smartgreenhouse_app/theme.dart';

class ReportsDateTile extends StatelessWidget {
  const ReportsDateTile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: BlocBuilder<ReportsCubit, ReportsState>(
        builder: (context, state) {
          if (state is ReportsLoadPending) {
            if (state.date != null) {
              return Text(state.date.toIso8601String());
            }
            return Text('Please select a date');
          }
          if (state is ReportsLoadSuccess) {
            return Text(state.date.toIso8601String()); 
          }
          return Text('Please select a date');
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
        if (date != null) {
          context.bloc<ReportsCubit>().date(date);
        }
      },
    );
  }
}
