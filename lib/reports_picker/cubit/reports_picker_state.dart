part of 'reports_picker_cubit.dart';

class ReportsPickerState extends Equatable {
  final Particle particle;
  final Sensor sensor;
  final DateTime dateTime;
  final bool calculateAverage;

  final bool isValid;

  ReportsPickerState({
    Particle particle,
    Sensor sensor,
    DateTime dateTime,
    this.calculateAverage = true,
  }) : particle = particle,
       sensor = sensor,
       dateTime = dateTime ?? DateTime.now(),
       isValid = (particle != null) && (sensor != null) && (dateTime != null);

  @override
  List<Object> get props => [particle, sensor, dateTime, calculateAverage, isValid];

  ReportsPickerState copyWith({Particle particle, Sensor sensor, DateTime dateTime, bool calculateAverage}) => ReportsPickerState(
    particle: particle ?? this.particle,
    sensor: sensor ?? this.sensor,
    dateTime: dateTime ?? this.dateTime,
    calculateAverage: calculateAverage ?? this.calculateAverage,
  );
}
