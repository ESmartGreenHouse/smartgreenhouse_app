import 'dart:math';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class GaugeCard extends StatelessWidget {
  final String name;
  final String unit;
  final int value;
  final int max;
  final String colorHex;
  final IconData iconData;

  const GaugeCard({
    @required this.name,
    @required this.unit,
    @required this.value,
    @required this.max,
    @required this.colorHex,
    this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Stack(
        alignment: Alignment.center,
        children: [
          iconData != null ? Icon(
            iconData, size: 100.0,
            color: Colors.grey[300],
          ) : SizedBox(),
          charts.PieChart(
              <charts.Series<GaugeSegment, String>>[
                charts.Series<GaugeSegment, String>(
                  id: 'Segment',
                  domainFn: (segment, _) => segment.segment,
                  measureFn: (segment, _) => segment.size,
                  colorFn: (segment, __) => segment.segment == 'value' ? charts.Color.fromHex(code: colorHex) : charts.Color.fromHex(code: colorHex).lighter.lighter.lighter.lighter.lighter.lighter.lighter,
                  data: [GaugeSegment('value', value), GaugeSegment('empty', max - value)],
                ),
              ], 
              defaultRenderer:charts. ArcRendererConfig(
                arcWidth: 16,
                startAngle: 4 / 5 * pi,
                arcLength: 7 / 5 * pi
              )
            ),
          Text(
            '${value ?? '-'} $unit',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
          ),
          Padding(
            padding: EdgeInsets.only(top: 100.0),
            child: Text(name, style: TextStyle(color: Colors.grey)),
          ),
        ],
      ),
    );
  }
}

class GaugeSegment{
  String segment;
  int size;

  GaugeSegment(this.segment, this.size);
}
