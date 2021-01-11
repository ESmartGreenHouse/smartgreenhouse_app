import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:greenhouse_repository/greenhouse_repository.dart';
import 'package:meta/meta.dart';

part 'sensor_values_state.dart';

class SensorValuesCubit extends Cubit<SensorValuesState> {
  final GreenhouseRepository greenhouseRepository;

  SensorValuesCubit({
    @required this.greenhouseRepository,
  }) : super(SensorValuesInitial());

  void load(List<Particle> particles) async {
    emit(SensorValuesLoadInProgress());

    final ownedParticles = particles.where((p) => p.isOwned);

    try {
      final sensors = await greenhouseRepository.getSensorValuesOfParticle(ownedParticles.first);
      emit(SensorValuesLoadSuccess(sensors));
    } catch(e) {
      emit(SensorValuesLoadFailure());
    }
  }
}
