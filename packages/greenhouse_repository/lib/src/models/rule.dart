import 'package:equatable/equatable.dart';
import 'package:greenhouse_repository/greenhouse_repository.dart';
import 'package:meta/meta.dart';

enum RuleType { or, and }
enum RuleThreshold { lower, equal, higher }

class Rule extends Equatable {
  final Sensor sensor;
  final RuleThreshold thresholdType;
  final double threshold;
  final RuleType ruleType;

  Rule({
    @required this.sensor,
    @required this.thresholdType,
    @required this.threshold,
    this.ruleType = RuleType.and,
  });

  @override
  List<Object> get props => [sensor, thresholdType, threshold, ruleType];
}
