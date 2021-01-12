import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum SensorType { unknown, temperature, humidity, window, light, moisture }

extension SensorTypeExtension on SensorType {
  double get max {
    switch(this) {
      case SensorType.temperature:
        return 50.0;
      case SensorType.humidity:
        return 100.0;
      case SensorType.unknown:
      default:
        return null;
    }
  }

  String get unit {
    switch(this) {
      case SensorType.temperature:
        return '°C';
      case SensorType.humidity:
        return '%';
      case SensorType.unknown:
      default:
        return '';
    }
  }
}

extension on String {
  SensorType toSensorType() {
    if (this.toLowerCase().contains('temp')) return SensorType.temperature;
    if (this.toLowerCase().contains('hum')) return SensorType.humidity;
    if (this.toLowerCase().contains('window')) return SensorType.window;
    if (this.toLowerCase().contains('light')) return SensorType.light;
    if (this.toLowerCase().contains('moisture')) return SensorType.moisture;
    return SensorType.unknown;
  }
}

class Sensor extends Equatable {
  final String name;
  final SensorType type;
  final double value;

  Sensor({
    @required this.name,
    SensorType type,
    this.value,
  }) : type = type ?? name.toSensorType();

  @override
  List<Object> get props => [name, type, value];

  Sensor copyWith({double value}) => Sensor(
    name: name,
    type: type,
    value: value,
  );
}
