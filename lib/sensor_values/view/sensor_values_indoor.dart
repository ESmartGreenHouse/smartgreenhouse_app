import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_wall_layout/flutter_wall_layout.dart';
import 'package:smartgreenhouse_app/sensor_values/sensor_values.dart';
import 'package:smartgreenhouse_app/sensor_values/view/gauge_card.dart';
import 'package:smartgreenhouse_app/theme.dart';

class SensorValuesIndoor extends StatelessWidget {

  int _layersCount(Size size) {
    if (size.width > 1200) return 8;
    if (size.width > 800) return 6;
    if (size.width > 600) return 4;
    if (size.width > 400) return 3;
    return 2;
  }

  @override
  Widget build(BuildContext context) {
    return WallLayout(
      layersCount: _layersCount(MediaQuery.of(context).size),
      stones: [
        Stone(
          id: 1,
          width: 2,
          height: 2,
          child: Builder(
            builder: (context) => GaugeCard(
              name: 'Temperature',
              unit: '°C',
              value: context.select((SensorValuesCubit cubit) => cubit.state.indoorTemperature),
              max: 50, colorHex: '#FF792D',
              iconData: Icons.home,
            ),
          ),
        ),
        Stone(
          id: 2,
          width: 2,
          height: 2,
          child: Builder(
            builder: (context) => GaugeCard(
              name: 'Humidity',
              unit: '%',
              value: context.select((SensorValuesCubit cubit) => cubit.state.indoorHumidity),
              max: 100,
              colorHex: '#0069b4',
              iconData: Icons.home,
            ),
          ),
        ),
        Stone(
          id: 3,
          width: 1,
          height: 1,
          child: Card(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  Icons.grass, size: 80.0,
                  color: Colors.grey[300],
                ),
                Builder(
                  builder: (context) => Text(
                    '${context.select((SensorValuesCubit cubit) => cubit.state.moisture) ?? '-'} %',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 80.0),
                  child: Text('Moisture', style: TextStyle(color: Colors.grey)),
                ),
              ],
            ),
          ),
        ),
        Stone(
          id: 4,
          width: 1,
          height: 1,
          child: Card(
            child: Builder(
              builder: (context) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    context.select((SensorValuesCubit cubit) => cubit.state.isWindowOpen) == true
                      ? Icons.sensor_window_outlined
                      : Icons.sensor_window,
                    size: 50.0,
                    color: GreenHouseColors.black,
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    '${context.select((SensorValuesCubit cubit) => cubit.state.isWindowOpen) == true ? 'OPEN' : 'CLOSED'}',
                    style: TextStyle(color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
        Stone(
          id: 5,
          width: 1,
          height: 1,
          child: Card(
            child: Builder(
              builder: (context) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  context.select((SensorValuesCubit cubit) => cubit.state.isLightOn) == true
                    ? Icon(Icons.wb_incandescent, size: 50.0, color: GreenHouseColors.orange)
                    : Icon(Icons.wb_incandescent_outlined, size: 50.0, color: GreenHouseColors.black),
                  SizedBox(height: 5.0),
                  Text(
                    '${context.select((SensorValuesCubit cubit) => cubit.state.isLightOn) == true ? 'ON' : 'OFF'}',
                    style: TextStyle(color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
        Stone(
          id: 6,
          width: 1,
          height: 1,
          child: Card(
            child: Builder(
              builder: (context) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    context.select((SensorValuesCubit cubit) => cubit.state.isIrrigationOn) == true
                      ? Icons.invert_colors
                      : Icons.invert_colors_off,
                    size: 50.0,
                    color: GreenHouseColors.blue,
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    '${context.select((SensorValuesCubit cubit) => cubit.state.isIrrigationOn) == true ? 'ON' : 'OFF'}',
                    style: TextStyle(color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
