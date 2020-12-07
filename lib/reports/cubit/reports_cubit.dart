import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:greenhouse_repository/greenhouse_repository.dart';
import 'package:meta/meta.dart';

part 'reports_state.dart';

class ReportsCubit extends Cubit<ReportsState> {
  final GreenhouseRepository greenhouseRepository;

  ReportsCubit({@required this.greenhouseRepository}) 
    : assert(greenhouseRepository != null),
      super(ReportsInitial());

  void _load(Particle particle, Sensor sensor, DateTime date) async {
    emit(ReportsLoadInProgress());

    final result = await greenhouseRepository.getRecentMeasurement(particle: particle, sensor: sensor, date: date);
    if (result != null) {
      emit(ReportsLoadSuccess(
        particle: particle,
        sensor: sensor,
        date: date,
        measurement: result,
      ));
    } else {
      emit(ReportsLoadFailure());
    }
  }

  void date(DateTime date) async {
    final currentState = state;

    if (currentState is ReportsLoadSuccess) {
      _load(currentState.particle, currentState.sensor, date);
    } else if (currentState is ReportsLoadPending) {
      if (currentState.particle == null || currentState.sensor == null) {
        emit(ReportsLoadPending(date: date, message: 'Please select a sensor'));
      } else {
        _load(currentState.particle, currentState.sensor, date);
      }
    } else {
      emit(ReportsLoadPending(date: date, message: 'Please select a sensor'));
    }

  }

  void sensor(Particle particle, Sensor sensor) async {
    final currentState = state;

    if (currentState is ReportsLoadSuccess) {
      _load(particle, sensor, currentState.date);
    } else if (currentState is ReportsLoadPending) {
      if (currentState.date == null) {
        emit(ReportsLoadPending(particle: particle, sensor: sensor, message: 'Please select a date'));
      } else {
        _load(particle, sensor, currentState.date);
      }
    } else {
      emit(ReportsLoadPending(particle: particle, sensor: sensor, message: 'Please select a date'));
    }
  }
}
