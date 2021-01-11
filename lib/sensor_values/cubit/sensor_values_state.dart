part of 'sensor_values_cubit.dart';

abstract class SensorValuesState extends Equatable {
  const SensorValuesState();

  @override
  List<Object> get props => [];
}

class SensorValuesInitial extends SensorValuesState {}

class SensorValuesLoadInProgress extends SensorValuesState {}

class SensorValuesLoadSuccess extends SensorValuesState {
  final List<Sensor> sensors;

  SensorValuesLoadSuccess(this.sensors);

  @override
  List<Object> get props => [sensors];
}

class SensorValuesLoadFailure extends SensorValuesState {
  final String message;

  SensorValuesLoadFailure([this.message = '']);

  @override
  List<Object> get props => [message];
}
