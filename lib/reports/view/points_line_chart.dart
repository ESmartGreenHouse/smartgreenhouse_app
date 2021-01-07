import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:greenhouse_repository/greenhouse_repository.dart';

class PointsLineChart extends StatelessWidget {
  final List<Measurement> measurement;

  PointsLineChart(this.measurement);

  @override
  Widget build(BuildContext context) {
    final seriesList = [
      charts.Series<Measurement, DateTime>(
        id: 'Measurement',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (Measurement sales, _) => sales.timestamp,
        measureFn: (Measurement sales, _) => sales.value,
        data: measurement,
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
}
