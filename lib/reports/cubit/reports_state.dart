part of 'reports_cubit.dart';

abstract class ReportsState extends Equatable {
  const ReportsState();

  @override
  List<Object> get props => [];
}

class ReportsInitial extends ReportsState {}

class ReportsLoadInProgress extends ReportsState {}

class ReportsLoadPending extends ReportsState {
  final Particle particle;
  final Sensor sensor;
  final DateTime date;
  final String message;

  ReportsLoadPending({
    this.particle,
    this.sensor,
    this.date,
    this.message = ''
  });

  @override
  List<Object> get props => [particle, sensor, date, message];
}

class ReportsLoadSuccess extends ReportsState {
  final Particle particle;
  final Sensor sensor;
  final DateTime date;
  final List<Measurement> measurement;

  ReportsLoadSuccess({
    @required this.particle,
    @required this.sensor,
    @required this.date,
    @required this.measurement,
  });

  @override
  List<Object> get props => [particle, sensor, date, measurement];
}

class ReportsLoadFailure extends ReportsState {
  final String message;

  ReportsLoadFailure([this.message = 'Reports load failure']);

  @override
  List<Object> get props => [message];
}
