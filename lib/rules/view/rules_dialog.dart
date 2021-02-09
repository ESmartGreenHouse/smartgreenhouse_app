import 'package:flutter/material.dart';
import 'package:smartgreenhouse_app/theme.dart';

class RulesDialog extends StatefulWidget {
  final String title;
  final String unit;
  final double value;
  final double min;
  final double max;
  final int steps;

  const RulesDialog({
    @required this.title,
    this.unit = '',
    @required this.value,
    this.min = 0.0,
    this.max = 100.0,
    this.steps = 10,
  });

  @override
  _RulesDialogState createState() => _RulesDialogState();
}

class _RulesDialogState extends State<RulesDialog> {
  double _value;

  @override
  void initState() {
    _value = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Center(child: Text(widget.title)),
      children: [
        SizedBox(height: 20.0),
        Center(child: Text(
          '${_value.roundToDouble()} ${widget.unit}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: GreenHouseColors.green,
            fontSize: 20.0
          ),
        )),
        SizedBox(height: 20.0),
        Slider(
          value: _value,
          min: widget.min,
          max: widget.max,
          divisions: widget.steps,
          label: '${_value.roundToDouble()} ${widget.unit}',
          onChanged: (value) {
            setState(() {
              _value = value;
            });
          },
        ),
        SizedBox(height: 20.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              child: Text('CANCEL'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('OK'),
              onPressed: () => Navigator.of(context).pop(_value.roundToDouble()),
            ),
          ],
        ),
      ],
    );
  }
}
