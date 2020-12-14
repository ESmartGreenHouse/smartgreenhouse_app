import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:greenhouse_repository/greenhouse_repository.dart';
import 'package:smartgreenhouse_app/tasks/tasks.dart';

class RuleThresholdDialog extends StatelessWidget {
  final Rule rule;
  final thresholdController = TextEditingController();

  RuleThresholdDialog({Key key, @required this.rule}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    thresholdController.text = rule.threshold.toString();

    return SimpleDialog(
      title: ListTile(
        title: Text('Threshold', style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('${rule.sensor.name} sensor'),
        leading: rule.thresholdType.icon(rule.ruleType.color()),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 25, right: 25),
          child: TextFormField(
            controller: thresholdController,
            autofocus: true,
            onFieldSubmitted: (_) => Navigator.of(context).pop(double.tryParse(thresholdController.text)),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d*)'))
            ],
            decoration: InputDecoration(
              labelText: 'Threshold',
              hintText: '100.0',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FlatButton(
                child: Text('Cancel', style: TextStyle(color: Theme.of(context).primaryColor)),
                onPressed: () => Navigator.of(context).pop(),
              ),
              FlatButton(
                child: Text('Ok', style: TextStyle(color: Theme.of(context).primaryColor)),
                onPressed: () => Navigator.of(context).pop(double.tryParse(thresholdController.text)),
              ),
            ],
          ),
        )
      ],
    );
  }
}
