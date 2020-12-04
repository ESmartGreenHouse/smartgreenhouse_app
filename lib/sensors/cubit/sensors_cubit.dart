import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:greenhouse_repository/greenhouse_repository.dart';
import 'package:meta/meta.dart';

part 'sensors_state.dart';

class SensorsCubit extends Cubit<SensorsState> {
  final GreenhouseRepository greenhouseRepository;
  
  SensorsCubit({@required this.greenhouseRepository})
    : assert(greenhouseRepository != null),
      super(SensorsInitial());

  void load() async {
    emit(SensorsLoadInProgress());

    final result = await greenhouseRepository.getSensors();
    if (result != null) {
      if (result.isNotEmpty) {
        emit(SensorsLoadSuccess(result));
      } else {
        emit(SensorsLoadFailure('No sensors found!'));
      }
    } else {
      emit(SensorsLoadFailure());
    }
  }
}
