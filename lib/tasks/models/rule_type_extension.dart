import 'package:flutter/material.dart';
import 'package:greenhouse_repository/greenhouse_repository.dart';
import 'package:smartgreenhouse_app/theme.dart';

extension RuleTypeExtension on RuleType {

  String string() {
    switch (this) {
      case RuleType.and:
        return 'must be';
      case RuleType.or:
        return 'could be';
      default:
        return this.toString();
    }
  }

  Color color() {
    switch (this) {
      case RuleType.and:
        return GreenHouseColors.green;
      case RuleType.or:
        return GreenHouseColors.orange;
      default:
        return GreenHouseColors.black;
    }
  }
}
