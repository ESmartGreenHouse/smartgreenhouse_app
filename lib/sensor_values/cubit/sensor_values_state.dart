part of 'sensor_values_cubit.dart';

class SensorValuesState extends Equatable {
  final int indoorTemperature;
  final int indoorHumidity;
  final int outdoorTemperature;
  final int outdoorHumidity;
  final int moisture;
  final bool isWindowOpen;
  final bool isLightOn;
  final bool isIrrigationOn;
  final bool isWindHigh;
  final bool isBrightnessHigh;
  final bool isRain;


  SensorValuesState({
    this.indoorTemperature,
    this.indoorHumidity,
    this.outdoorTemperature,
    this.outdoorHumidity,
    this.moisture,
    this.isWindowOpen,
    this.isLightOn,
    this.isIrrigationOn,
    this.isWindHigh,
    this.isBrightnessHigh,
    this.isRain,
  });

  @override
  List<Object> get props => [
    indoorTemperature,
    indoorHumidity,
    outdoorTemperature,
    outdoorHumidity,
    moisture,
    isWindowOpen,
    isLightOn,
    isIrrigationOn,
    isWindHigh,
    isBrightnessHigh,
    isRain,
  ];

  SensorValuesState copyWith({
    int indoorTemperature,
    int indoorHumidity,
    int outdoorTemperature,
    int outdoorHumidity,
    int moisture,
    bool isWindowOpen,
    bool isLightOn,
    bool isIrrigationOn,
    bool isWindHigh,
    bool isBrightnessHigh,
    bool isRain,
  }) {
    return SensorValuesState(
      indoorTemperature: indoorTemperature ?? this.indoorTemperature,
      indoorHumidity: indoorHumidity ?? this.indoorHumidity,
      outdoorTemperature: outdoorTemperature ?? this.outdoorTemperature,
      outdoorHumidity: outdoorHumidity ?? this.outdoorHumidity,
      moisture: moisture ?? this.moisture,
      isWindowOpen: isWindowOpen ?? this.isWindowOpen,
      isLightOn: isLightOn ?? this.isLightOn,
      isIrrigationOn: isIrrigationOn ?? this.isIrrigationOn,
      isWindHigh: isWindHigh ?? this.isWindHigh,
      isBrightnessHigh: isBrightnessHigh ?? this.isBrightnessHigh,
      isRain: isRain ?? this.isRain,
    );
  }
}
