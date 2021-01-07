import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:greenhouse_repository/greenhouse_repository.dart';

part 'reports_picker_state.dart';

class ReportsPickerCubit extends Cubit<ReportsPickerState> {
  ReportsPickerCubit() : super(ReportsPickerState());

  void sensor(Particle particle, Sensor sensor) {
    emit(state.copyWith(particle: particle, sensor: sensor));
  }

  void date(DateTime date) {
    emit(state.copyWith(dateTime: date));
  }

  void time(TimeOfDay time) {
    if (state.dateTime == null) {
      emit(state.copyWith(dateTime: DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        time.hour,
        time.minute,
      )));
    } else {
      emit(state.copyWith(dateTime: DateTime(
        state.dateTime.year,
        state.dateTime.month,
        state.dateTime.day,
        time.hour,
        time.minute,
      )));
    }
  }

  void toggleAverage() {
    emit(state.copyWith(calculateAverage: !state.calculateAverage));
  }
}
