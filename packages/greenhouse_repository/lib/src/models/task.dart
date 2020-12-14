import 'package:equatable/equatable.dart';
import 'package:greenhouse_repository/greenhouse_repository.dart';
import 'package:meta/meta.dart';

enum TaskAction { turnOn, turnOff }

class Task extends Equatable {
  final List<Rule> rules;
  final Actuator actuator;
  final TaskAction action;

  Task({
    @required this.rules,
    @required this.actuator,
    this.action = TaskAction.turnOff,
  });

  @override
  List<Object> get props => [rules, actuator, action];
}
