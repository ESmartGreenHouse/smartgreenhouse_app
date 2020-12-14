import 'package:equatable/equatable.dart';
import 'package:greenhouse_repository/greenhouse_repository.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

enum RuleType { or, and }
enum RuleThreshold { lower, equal, higher }

class Rule extends Equatable {
  final String uuid;
  final Sensor sensor;
  final RuleThreshold thresholdType;
  final double threshold;
  final RuleType ruleType;

  Rule({
    String uuid,
    @required this.sensor,
    @required this.thresholdType,
    @required this.threshold,
    this.ruleType = RuleType.and,
  }) : this.uuid = uuid ?? Uuid().v4();

  @override
  List<Object> get props => [uuid, sensor, thresholdType, threshold, ruleType];

  Rule copyWith({double threshold}) => Rule(
    uuid: uuid,
    sensor: sensor, 
    thresholdType: thresholdType, 
    threshold: threshold ?? this.threshold,
    ruleType: ruleType,
  );
}
