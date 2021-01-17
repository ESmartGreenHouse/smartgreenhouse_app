import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_wall_layout/flutter_wall_layout.dart';
import 'package:smartgreenhouse_app/sensor_values/sensor_values.dart';
import 'package:smartgreenhouse_app/sensor_values/view/gauge_card.dart';
import 'package:smartgreenhouse_app/theme.dart';

class SensorValuesIndoor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<SensorValuesCubit, SensorValuesState>(
      builder: (context, state) {
        if (state is SensorValuesLoadSuccess) {
          return WallLayout(
            layersCount: 3,
            stones: [
              Stone(
                id: 1,
                width: 2,
                height: 2,
                child: GaugeCard(name: 'Temperature', unit: '°C', value: state.overview.indoorTemperature, max: 50, colorHex: '#FF792D', iconData: Icons.home),
              ),
              Stone(
                id: 2,
                width: 2,
                height: 2,
                child: GaugeCard(name: 'Humidity', unit: '%', value: state.overview.indoorHumidity, max: 100, colorHex: '#0069b4', iconData: Icons.home),
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
                      Text(
                        '60 %',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(state.overview.isWindowOpen ? Icons.sensor_window_outlined : Icons.sensor_window, size: 50.0, color: GreenHouseColors.black),
                      SizedBox(height: 5.0),
                      Text('${state.overview.isWindowOpen ? 'OPEN' : 'CLOSED'}', style: TextStyle(color: Colors.grey), textAlign: TextAlign.center),
                    ],
                  ),
                ),
              ),
              Stone(
                id: 5,
                width: 1,
                height: 1,
                child: Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(true ? Icons.wb_incandescent : Icons.wb_incandescent_outlined, size: 50.0, color: true ? GreenHouseColors.orange : GreenHouseColors.black),
                      SizedBox(height: 5.0),
                      Text('${true ? 'ON' : 'OFF'}', style: TextStyle(color: Colors.grey), textAlign: TextAlign.center),
                    ],
                  ),
                ),
              ),
              Stone(
                id: 6,
                width: 1,
                height: 1,
                child: Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(false ? Icons.invert_colors : Icons.invert_colors_off, size: 50.0, color: GreenHouseColors.blue),
                      SizedBox(height: 5.0),
                      Text('${false ? 'ON' : 'OFF'}', style: TextStyle(color: Colors.grey), textAlign: TextAlign.center),
                    ],
                  ),
                ),
              ),
            ],
          );
        }
        if (state is SensorValuesLoadFailure) {
          return ListTile(
            title: Text('Failed to load sensor values!'),
            leading: Icon(Icons.error, color: GreenHouseColors.orange),
          );
        }
        return LinearProgressIndicator();
      },
    );
  }
}
