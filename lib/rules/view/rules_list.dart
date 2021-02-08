import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smartgreenhouse_app/theme.dart';

class RulesList extends StatelessWidget {
  const RulesList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: Card(
            margin: EdgeInsets.all(16.0),
            child: Column(
              children: [
                ListTile(
                  title: Text('Window', style: TextStyle(fontWeight: FontWeight.bold, color: GreenHouseColors.green)),
                ),
                ExpansionTile(
                  initiallyExpanded: true,
                  title: Text('Open if'),
                  leading: Icon(Icons.sensor_window_outlined),
                  children: [
                    ListTile(
                      title: Text('20.0 °C'),
                      subtitle: Text('Indoor Temperature is higher than ${'20.0'} °C\nand is higher than outdoor temperature'),
                      leading: Icon(Icons.device_thermostat, color: GreenHouseColors.black),
                      trailing: IconButton(
                        icon: Icon(Icons.edit),
                        color: GreenHouseColors.black,
                        onPressed: () {}
                      ),
                    ),
                    ListTile(
                      title: Text('70 %'),
                      subtitle: Text('Indoor Humidity is higher than ${'70'} %\nand is higher than outdoor humidity'),
                      leading: Icon(Icons.water_damage, color: GreenHouseColors.black),
                      trailing: IconButton(
                        icon: Icon(Icons.edit),
                        color: GreenHouseColors.black,
                        onPressed: () {}
                      ),
                    ),
                  ],
                ),
                ExpansionTile(
                  initiallyExpanded: true,
                  title: Text('Close if'),
                  leading: Icon(Icons.sensor_window),
                  children: [
                    ListTile(
                      title: Text('20 km/h'),
                      subtitle: Text('Wind is higher than ${'20'} km/h'),
                      leading: Icon(Icons.toys, color: GreenHouseColors.black),
                      trailing: IconButton(
                        icon: Icon(Icons.edit),
                        color: GreenHouseColors.black,
                        onPressed: () {}
                      ),
                    ),
                    ListTile(
                      title: Text('Raining'),
                      subtitle: Text('Weather'),
                      leading: Icon(FontAwesomeIcons.cloudRain, color: GreenHouseColors.black),
                      trailing: IconButton(
                        icon: Icon(Icons.edit),
                        color: GreenHouseColors.black,
                        onPressed: () {}
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: Card(
            margin: EdgeInsets.all(16.0),
            child: Column(
              children: [
                ListTile(
                  title: Text('Irrigation', style: TextStyle(fontWeight: FontWeight.bold, color: GreenHouseColors.green)),
                ),
                ExpansionTile(
                  initiallyExpanded: true,
                  title: Text('Turn on if'),
                  leading: Icon(Icons.invert_colors),
                  children: [
                    ListTile(
                      title: Text('20 %'),
                      subtitle: Text('Moisture is below ${'20'} %'),
                      leading: Icon(Icons.grass, color: GreenHouseColors.black),
                      trailing: IconButton(
                        icon: Icon(Icons.edit),
                        color: GreenHouseColors.black,
                        onPressed: () {}
                      ),
                    ),
                  ],
                ),
                ExpansionTile(
                  initiallyExpanded: true,
                  title: Text('Turn off if'),
                  leading: Icon(Icons.invert_colors_off),
                  children: [
                    ListTile(
                      title: Text('60 %'),
                      subtitle: Text('Moisture is above ${'60'} %'),
                      leading: Icon(Icons.grass, color: GreenHouseColors.black),
                      trailing: IconButton(
                        icon: Icon(Icons.edit),
                        color: GreenHouseColors.black,
                        onPressed: () {}
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: Card(
            margin: EdgeInsets.all(16.0),
            child: Column(
              children: [
                ListTile(
                  title: Text('Light', style: TextStyle(fontWeight: FontWeight.bold, color: GreenHouseColors.green)),
                ),
                ExpansionTile(
                  initiallyExpanded: true,
                  title: Text('Turn on if'),
                  leading: Icon(Icons.invert_colors),
                  children: [
                    ListTile(
                      title: Text('Low'),
                      subtitle: Text('Brightness'),
                      leading: Icon(Icons.nights_stay, color: GreenHouseColors.black),
                      trailing: IconButton(
                        icon: Icon(Icons.edit),
                        color: GreenHouseColors.black,
                        onPressed: () {}
                      ),
                    ),
                  ],
                ),
                ExpansionTile(
                  initiallyExpanded: true,
                  title: Text('Turn off if'),
                  leading: Icon(Icons.invert_colors_off),
                  children: [
                    ListTile(
                      title: Text('High'),
                      subtitle: Text('Brightness'),
                      leading: Icon(Icons.wb_sunny, color: GreenHouseColors.black),
                      trailing: IconButton(
                        icon: Icon(Icons.edit),
                        color: GreenHouseColors.black,
                        onPressed: () {}
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
