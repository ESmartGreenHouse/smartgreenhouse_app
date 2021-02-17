part of 'rules_cubit.dart';

class RulesState extends Equatable {
  final Particle particle;

  final Threshold maxTemperature;
  final Threshold maxHumidity;
  final Threshold maxWindSpeed;
  final Threshold minMoisture;
  final Threshold maxMoisture;
  final Threshold daylight;

  const RulesState({
    this.particle,
    this.maxTemperature,
    this.maxHumidity,
    this.maxWindSpeed,
    this.minMoisture,
    this.maxMoisture,
    this.daylight,
  });

  @override
  List<Object> get props => [
    particle,
    maxTemperature,
    maxHumidity,
    maxWindSpeed,
    minMoisture,
    maxMoisture,
    daylight,
  ];

  RulesState copyWith({
    Threshold maxTemperature,
    Threshold maxHumidity,
    Threshold maxWindSpeed,
    Threshold minMoisture,
    Threshold maxMoisture,
    Threshold daylight,
  }) => RulesState(
    particle: particle,
    maxTemperature: maxTemperature ?? this.maxTemperature,
    maxHumidity: maxHumidity ?? this.maxHumidity,
    maxWindSpeed: maxWindSpeed ?? this.maxWindSpeed,
    minMoisture: minMoisture ?? this.minMoisture,
    maxMoisture: maxMoisture ?? this.maxMoisture,
    daylight: daylight ?? this.daylight,
  );
}
