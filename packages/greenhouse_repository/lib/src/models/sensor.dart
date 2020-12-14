import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum SensorType { unknown, number, boolean }

class Sensor extends Equatable {
  final String name;
  final SensorType type;

  Sensor({
    @required this.name,
    this.type = SensorType.unknown,
  });

  @override
  List<Object> get props => [name, type];
}
