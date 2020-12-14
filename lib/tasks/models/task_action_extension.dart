import 'package:flutter/material.dart';
import 'package:greenhouse_repository/greenhouse_repository.dart';
import 'package:smartgreenhouse_app/theme.dart';

extension TaskActionExtension on TaskAction {

  String string() {
    switch (this) {
      case TaskAction.turnOff:
        return 'OFF';
      case TaskAction.turnOn:
        return 'ON';
      default:
        return this.toString();
    }
  }

  Widget icon() {
    switch (this) {
      case TaskAction.turnOff:
        return Icon(Icons.highlight_off, color: GreenHouseColors.orange);
      case TaskAction.turnOn:
        return Icon(Icons.check_circle_outline, color: GreenHouseColors.green);
      default:
        return Icon(Icons.help_outline, color: GreenHouseColors.black);
    }
  }
}
