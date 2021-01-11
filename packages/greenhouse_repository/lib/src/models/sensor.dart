import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum SensorType { unknown, number, boolean }

class Sensor extends Equatable {
  final String name;
  final SensorType type;
  final double value;

  Sensor({
    @required this.name,
    this.type = SensorType.unknown,
    this.value,
  });

  @override
  List<Object> get props => [name, type, value];

  Sensor copyWith({double value}) => Sensor(
    name: name,
    type: type,
    value: value,
  );
}
