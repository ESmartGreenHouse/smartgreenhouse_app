import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greenhouse_repository/greenhouse_repository.dart';
import 'package:smartgreenhouse_app/reports/reports.dart';
import 'package:smartgreenhouse_app/theme.dart';

class PointsLineChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportsCubit, ReportsState>(
      builder: (context, state) {
        if (state is ReportsLoadSuccess) {
          if (state.measurement == null || state.measurement.isEmpty) {
            return ListTile(
              title: Text('No measurements found for sensor at date'),
              leading: Icon(Icons.warning, color: GreenHouseColors.orange),
            );
          }

          final seriesList = [
            charts.Series<Measurement, DateTime>(
              id: 'Measurement',
              colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
              domainFn: (Measurement sales, _) => sales.timestamp,
              measureFn: (Measurement sales, _) => sales.value,
              data: state.measurement,
            ),
          ];

          return charts.TimeSeriesChart(
            seriesList,
            animate: true,
            defaultRenderer: charts.LineRendererConfig(includePoints: true),
            primaryMeasureAxis: new charts.NumericAxisSpec(
            tickProviderSpec: charts.BasicNumericTickProviderSpec(zeroBound: false)),
          );
        }
        if (state is ReportsLoadInProgress) {
          return LinearProgressIndicator();
        }
        if (state is ReportsLoadFailure) {
          return ListTile(
            title: Text(state.message),
            leading: Icon(Icons.error, color: GreenHouseColors.orange),
          );
        }
        if (state is ReportsLoadPending) {
          return ListTile(
            title: Text(state.message),
            leading: Icon(Icons.info, color: GreenHouseColors.orange),
          );
        }
        return Container();
      },
    );
  }
}
