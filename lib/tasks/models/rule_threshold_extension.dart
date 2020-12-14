import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:greenhouse_repository/greenhouse_repository.dart';
import 'package:smartgreenhouse_app/theme.dart';

extension RuleThresholdExtension on RuleThreshold {
  
  String string() {
    switch (this) {
      case RuleThreshold.equal:
        return 'equal to';
      case RuleThreshold.higher:
        return 'above';
      case RuleThreshold.lower:
        return 'below';
      default:
        return this.toString();
    }
  }

  Widget icon([Color color = GreenHouseColors.black]) {
    switch (this) {
      case RuleThreshold.equal:
        return FaIcon(FontAwesomeIcons.equals, color: color);
      case RuleThreshold.higher:
        return FaIcon(FontAwesomeIcons.greaterThan, color: color);
      case RuleThreshold.lower:
        return FaIcon(FontAwesomeIcons.lessThan, color: color);
      default:
        return FaIcon(FontAwesomeIcons.notEqual, color: color);
    }
  }

}
