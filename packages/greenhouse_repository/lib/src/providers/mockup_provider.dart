import 'package:greenhouse_repository/greenhouse_repository.dart';

class MockupProvider {
  static List<Task> _tasks = [
    Task(
      rules: [
        Rule(sensor: Sensor(name: 'Wind'), thresholdType: RuleThreshold.higher, threshold: 100, ruleType: RuleType.or),
        Rule(sensor: Sensor(name: 'Rain'), thresholdType: RuleThreshold.equal, threshold: 1, ruleType: RuleType.or)
      ],
      actuator: Actuator(name: 'Window'),
      action: TaskAction.turnOff,
    ),
    Task(
      rules: [
        Rule(sensor: Sensor(name: 'CO2'), thresholdType: RuleThreshold.higher, threshold: 100),
        Rule(sensor: Sensor(name: 'Wind'), thresholdType: RuleThreshold.lower, threshold: 100),
        Rule(sensor: Sensor(name: 'Rain'), thresholdType: RuleThreshold.equal, threshold: 0),
      ],
      actuator: Actuator(name: 'Window'),
      action: TaskAction.turnOn,
    ),
    Task(
      rules: [Rule(sensor: Sensor(name: 'Soil moisture'), thresholdType: RuleThreshold.lower, threshold: 80)],
      actuator: Actuator(name: 'Water'),
      action: TaskAction.turnOn,
    ),
    Task(
      rules: [Rule(sensor: Sensor(name: 'Soil moisture'), thresholdType: RuleThreshold.higher, threshold: 120)],
      actuator: Actuator(name: 'Water'),
      action: TaskAction.turnOff,
    ),
  ];

  List<Task> get tasks => _tasks;

  void updateRule(Rule update) {
    print(_tasks);

    _tasks = _tasks.map((task) => task.copyWith(
      rules: task.rules.map((rule) => rule.uuid == update.uuid ? update : rule).toList(),
    )).toList();

    print(_tasks);
  }
}
