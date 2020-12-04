part of 'sensors_cubit.dart';

abstract class SensorsState extends Equatable {
  const SensorsState();

  @override
  List<Object> get props => [];
}

class SensorsInitial extends SensorsState {}

class SensorsLoadInProgress extends SensorsState {}

class SensorsLoadSuccess extends SensorsState {
  final List<Sensor> sensors;

  const SensorsLoadSuccess(this.sensors);

  @override
  List<Object> get props => [sensors];
}

class SensorsLoadFailure extends SensorsState {
  final String message;

  const SensorsLoadFailure([this.message = 'Failed to load sensors!']);

  @override
  List<Object> get props => [message];
}
