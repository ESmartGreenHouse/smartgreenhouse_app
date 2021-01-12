import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class SensorOverview extends Equatable {
  final int indoorTemperature;
  final int indoorHumidity;
  final int outdoorTemperature;
  final int outdoorHumidity;
  final int soilMoisture;
  final bool isWindowOpen;

  SensorOverview({
    @required this.indoorTemperature,
    @required this.indoorHumidity,
    @required this.outdoorTemperature,
    @required this.outdoorHumidity,
    @required this.soilMoisture,
    @required this.isWindowOpen,
  });

  @override
  List<Object> get props => [
    indoorTemperature,
    indoorHumidity,
    outdoorTemperature,
    outdoorHumidity,
    soilMoisture,
    isWindowOpen
  ];
}
