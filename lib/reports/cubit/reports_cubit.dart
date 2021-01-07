import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:greenhouse_repository/greenhouse_repository.dart';
import 'package:meta/meta.dart';

part 'reports_state.dart';

class ReportsCubit extends Cubit<ReportsState> {
  final GreenhouseRepository greenhouseRepository;

  ReportsCubit({@required this.greenhouseRepository}) 
    : assert(greenhouseRepository != null),
      super(ReportsInitial());

  void load(Particle particle, Sensor sensor, DateTime date, bool calculateAverage) async {
    emit(ReportsLoadInProgress());

    final result = await greenhouseRepository.getRecentMeasurement(
      particle: particle,
      sensor: sensor,
      date: date,
      calculateAverage: calculateAverage
    );

    if (result != null) {
      if (result.isNotEmpty) {
        emit(ReportsLoadSuccess(result));
      } else {
        emit(ReportsLoadFailure('No measurements found for sensor at date'));
      }
    } else {
      emit(ReportsLoadFailure());
    }
  }
}
