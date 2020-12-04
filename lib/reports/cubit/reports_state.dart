part of 'reports_cubit.dart';

abstract class ReportsState extends Equatable {
  const ReportsState();

  @override
  List<Object> get props => [];
}

class ReportsInitial extends ReportsState {}

class ReportsLoadInProgress extends ReportsState {}

class ReportsLoadSuccess extends ReportsState {
  final List<Measurement> measurement;

  ReportsLoadSuccess(this.measurement);

  @override
  List<Object> get props => [measurement];
}

class ReportsLoadFailure extends ReportsState {
  final String message;

  ReportsLoadFailure([this.message = 'Reports load failure']);

  @override
  List<Object> get props => [message];
}
