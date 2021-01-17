import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_wall_layout/flutter_wall_layout.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smartgreenhouse_app/sensor_values/sensor_values.dart';
import 'package:smartgreenhouse_app/sensor_values/view/gauge_card.dart';
import 'package:smartgreenhouse_app/theme.dart';

class SensorValuesOutdoor extends StatelessWidget {

  int _layersCount(Size size) {
    if (size.width > 1200) return 8;
    if (size.width > 800) return 6;
    if (size.width > 600) return 4;
    if (size.width > 400) return 3;
    return 2;
  }

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<SensorValuesCubit, SensorValuesState>(
      builder: (context, state) {
        if (state is SensorValuesLoadSuccess) {
          return WallLayout(
            layersCount: _layersCount(MediaQuery.of(context).size),
            stones: [
              Stone(
                id: 1,
                width: 2,
                height: 2,
                child: GaugeCard(name: 'Temperature', unit: '°C', value: state.overview.outdoorTemperature, max: 50, colorHex: '#FF792D'),
              ),
              Stone(
                id: 2,
                width: 2,
                height: 2,
                child: GaugeCard(name: 'Humidity', unit: '%', value: state.overview.outdoorHumidity, max: 100, colorHex: '#0069b4'),
              ),
              Stone(
                id: 3,
                width: 1,
                height: 1,
                child: Card(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Icon(Icons.toys, size: 60.0, color: Colors.grey[300]),
                      Text('High', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0)),
                      Padding(
                        padding: EdgeInsets.only(top: 80.0),
                        child: Text('Windspeed', style: TextStyle(color: Colors.grey)),
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
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Icon(Icons.brightness_low, size: 60.0, color: Colors.grey[300]),
                      Text('Low', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0)),
                      Padding(
                        padding: EdgeInsets.only(top: 80.0),
                        child: Text('Brightness', style: TextStyle(color: Colors.grey)),
                      ),
                    ],
                  ),
                ),
              ),
              Stone(
                id: 5,
                width: 1,
                height: 1,
                child: Card(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Icon(FontAwesomeIcons.cloudRain, size: 60.0, color: Colors.grey[300]),
                      Text('Rain', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0)),
                      Padding(
                        padding: EdgeInsets.only(top: 80.0),
                        child: Text('Weather', style: TextStyle(color: Colors.grey)),
                      ),
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
