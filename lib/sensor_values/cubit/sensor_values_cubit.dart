import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:greenhouse_repository/greenhouse_repository.dart';
import 'package:meta/meta.dart';

part 'sensor_values_state.dart';

class SensorValuesCubit extends Cubit<SensorValuesState> {
  final GreenhouseRepository greenhouseRepository;

  SensorValuesCubit({
    @required this.greenhouseRepository,
  }) : super(SensorValuesState());

  void load(List<Particle> particles) async {
    final ownedParticles = particles.where((p) => p.isOwned);

    try {
      await for (final sensor in greenhouseRepository.getSensorValuesOfParticle(ownedParticles.first)) {
        if (sensor.name.contains('TempIndoor')) {
          emit(state.copyWith(indoorTemperature: sensor.value.toInt()));
        } else if (sensor.name.contains('HumIndoor')) {
          emit(state.copyWith(indoorHumidity: sensor.value.toInt()));
        } else if (sensor.name.contains('TempOutdoor')) {
          emit(state.copyWith(outdoorTemperature: sensor.value.toInt()));
        } else if (sensor.name.contains('HumOutdoor')) {
          emit(state.copyWith(outdoorHumidity: sensor.value.toInt()));
        } else if (sensor.name.contains('Moisture')) {
          emit(state.copyWith(moisture: sensor.value.toInt()));
        } else {
          print(sensor);
        }
      }

      await for (final actuator in greenhouseRepository.getActuatorValuesOfParticle(ownedParticles.first)) {
        if (actuator.name.contains('WindowState')) {
          emit(state.copyWith(isWindowOpen: actuator.value));
        } else if (actuator.name.contains('IrrigationState')) {
          emit(state.copyWith(isIrrigationOn: actuator.value));
        } else if (actuator.name.contains('LightState')) {
          emit(state.copyWith(isLightOn: actuator.value));
        } else if (actuator.name.contains('HighWindState')) {
          emit(state.copyWith(isWindHigh: actuator.value));
        } else if (actuator.name.contains('RainingState')) {
          emit(state.copyWith(isRain: actuator.value));
        } else {
          print(actuator);
        }
      }
    } catch(e) {
      print(e);
    }
  }
}
