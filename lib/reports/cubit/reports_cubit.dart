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

  void load(Sensor sensor) async {
    emit(ReportsLoadInProgress());

    final result = await greenhouseRepository.getMeasurement(sensor: sensor.name, start: DateTime(2019), end: DateTime(2021));
    if (result != null) {
      if (result.isNotEmpty) {
        emit(ReportsLoadSuccess(result));
      } else {
        emit(ReportsLoadFailure('No measurement found'));
      }
    } else {
      emit(ReportsLoadFailure());
    }
  }
}
