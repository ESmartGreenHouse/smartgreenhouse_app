import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:greenhouse_repository/greenhouse_repository.dart';
import 'package:meta/meta.dart';

part 'rules_state.dart';

class RulesCubit extends Cubit<RulesState> {
  final GreenhouseRepository greenhouseRepository;

  RulesCubit({
    @required this.greenhouseRepository
  }) : super(RulesState());

  void load(List<Particle> particles) {
    emit(RulesState(particle: particles.where((p) => p.isOwned).first));
    reload();
  }

  void reload() async {
    // Reset all previous values
    emit(RulesState(particle: state.particle));

    try {
      await for (final threshold in greenhouseRepository.getThresholdValuesOfParticle(state.particle)) {
        _thresholdToState(threshold);
      }
    } catch (e) {
      print(e);
    }
  }

  void reset() async {
    final defaultThresholds = await greenhouseRepository.getDefaultThresholds();
    if (defaultThresholds != null) {
      for (final threshold in defaultThresholds) {
        changeThreshold(threshold, threshold.value);
      }
    }
  }

  void changeThreshold(Threshold threshold, double value) async {
    // Previous value is invalid until result
    _thresholdToState(threshold.copyWith(value: null));

    try {
      await greenhouseRepository.setThreshold(state.particle, threshold.copyWith(value: value));

      // New value is valid
      _thresholdToState(threshold.copyWith(value: value));
    } catch(e) {
      print(e);

      // Recreate previous value
      _thresholdToState(threshold);
    }
  }

  void _thresholdToState(Threshold threshold) {
    if (threshold.name.contains('IndoorTemp')) {
      emit(state.copyWith(maxTemperature: threshold));
    } else if (threshold.name.contains('IndoorHum')) {
      emit(state.copyWith(maxHumidity: threshold));
    } else if (threshold.name.contains('HighWind')) {
      emit(state.copyWith(maxWindSpeed: threshold));
    } else if (threshold.name.contains('LowMoisture')) {
      emit(state.copyWith(minMoisture: threshold));
    } else {
      print(threshold);
    }
  }
}
