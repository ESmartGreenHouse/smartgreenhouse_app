import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smartgreenhouse_app/common/custom_grid.dart';
import 'package:smartgreenhouse_app/rules/rules.dart';
import 'package:smartgreenhouse_app/theme.dart';

class RulesList extends StatelessWidget {
  const RulesList({Key key}) : super(key: key);

  int _columnCount(Size size) {
    if (size.width > 2000) return 4;
    if (size.width > 1500) return 3;
    if (size.width > 1000) return 2;
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomGrid(
          columnCount: _columnCount(MediaQuery.of(context).size),
          children: [
            Theme(
              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: Card(
                margin: EdgeInsets.all(8.0),
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
                        BlocBuilder<RulesCubit, RulesState>(
                          buildWhen: (previous, current) => previous.maxTemperature != current.maxTemperature,
                          builder: (context, state) => ListTile(
                            isThreeLine: true,
                            title: Text('${state.maxTemperature?.value ?? '-'} °C'),
                            subtitle: Text('Indoor Temperature is higher than ${state.maxTemperature?.value ?? '-'} °C and is higher than outdoor temperature'),
                            leading: Icon(Icons.device_thermostat, color: GreenHouseColors.black),
                            trailing: IconButton(
                              icon: state.maxTemperature?.value != null ? Icon(Icons.edit) : CircularProgressIndicator(),
                              color: GreenHouseColors.black,
                              onPressed: () async {
                                if (state.maxTemperature != null) {
                                  final value = await showDialog<double>(context: context, builder: (_) => RulesDialog(
                                    title: 'Indoor Temperature',
                                    unit: '°C',
                                    value: state.maxTemperature.value,
                                    min: 0.0,
                                    max: 50.0,
                                    steps: 25,
                                  ));
                                  if (value != null) {
                                    context.read<RulesCubit>().changeThreshold(state.maxTemperature, value);
                                  }
                                }
                              }
                            ),
                          ),
                        ),
                        BlocBuilder<RulesCubit, RulesState>(
                          buildWhen: (previous, current) => previous.maxHumidity != current.maxHumidity,
                          builder: (context, state) => ListTile(
                            isThreeLine: true,
                            title: Text('${state.maxHumidity?.value ?? '-'} %'),
                            subtitle: Text('Indoor Humidity is higher than ${state.maxHumidity?.value ?? '-'} % and is higher than outdoor humidity'),
                            leading: Icon(Icons.water_damage, color: GreenHouseColors.black),
                            trailing: IconButton(
                              icon: state.maxHumidity?.value != null ? Icon(Icons.edit) : CircularProgressIndicator(),
                              color: GreenHouseColors.black,
                              onPressed: () async {
                                if (state.maxHumidity != null) {
                                  final value = await showDialog<double>(context: context, builder: (_) => RulesDialog(
                                    title: 'Indoor Humidity',
                                    unit: '%',
                                    value: state.maxHumidity.value,
                                    min: 0.0,
                                    max: 100.0,
                                    steps: 50,
                                  ));
                                  if (value != null) {
                                    context.read<RulesCubit>().changeThreshold(state.maxHumidity, value);
                                  }
                                }
                              }
                            ),
                          ),
                        ),
                      ],
                    ),
                    ExpansionTile(
                      initiallyExpanded: true,
                      title: Text('Close if'),
                      leading: Icon(Icons.sensor_window),
                      children: [
                        BlocBuilder<RulesCubit, RulesState>(
                          buildWhen: (previous, current) => previous.maxWindSpeed != current.maxWindSpeed,
                          builder: (context, state) => ListTile(
                            isThreeLine: true,
                            title: Text('${state.maxWindSpeed?.value ?? '-'} km/h'),
                            subtitle: Text('Wind is higher than ${state.maxWindSpeed?.value ?? '-'} km/h'),
                            leading: Icon(Icons.toys, color: GreenHouseColors.black),
                            trailing: IconButton(
                              icon: state.maxWindSpeed?.value != null ? Icon(Icons.edit) : CircularProgressIndicator(),
                              color: GreenHouseColors.black,
                              onPressed: () async {
                                if (state.maxWindSpeed != null) {
                                  final value = await showDialog<double>(context: context, builder: (_) => RulesDialog(
                                    title: 'Windspeed',
                                    unit: 'km/h',
                                    value: state.maxWindSpeed.value,
                                    min: 0.0,
                                    max: 50.0,
                                    steps: 25,
                                  ));
                                  if (value != null) {
                                    context.read<RulesCubit>().changeThreshold(state.maxWindSpeed, value);
                                  }
                                }
                              }
                            ),
                          ),
                        ),
                        ListTile(
                          isThreeLine: true,
                          title: Text('Raining'),
                          subtitle: Text('Weather'),
                          leading: Icon(FontAwesomeIcons.cloudRain, color: GreenHouseColors.black),
                          // trailing: IconButton(
                          //   icon: Icon(Icons.edit),
                          //   color: GreenHouseColors.black,
                          //   onPressed: () {}
                          // ),
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
                margin: EdgeInsets.all(8.0),
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
                        BlocBuilder<RulesCubit, RulesState>(
                          buildWhen: (previous, current) => previous.minMoisture != current.minMoisture,
                          builder: (context, state) => ListTile(
                            isThreeLine: true,
                            title: Text('${state.minMoisture?.value ?? '-'} %'),
                            subtitle: Text('Moisture is below ${state.minMoisture?.value ?? '-'} %'),
                            leading: Icon(Icons.grass, color: GreenHouseColors.black),
                            trailing: IconButton(
                              icon: state.minMoisture?.value != null ? Icon(Icons.edit) : CircularProgressIndicator(),
                              color: GreenHouseColors.black,
                              onPressed: () async {
                                if (state.minMoisture != null) {
                                  final value = await showDialog<double>(context: context, builder: (_) => RulesDialog(
                                    title: 'Moisture',
                                    unit: '%',
                                    value: state.minMoisture.value,
                                    min: 0.0,
                                    max: 100.0,
                                    steps: 50,
                                  ));
                                  if (value != null) {
                                    context.read<RulesCubit>().changeThreshold(state.minMoisture, value);
                                  }
                                }
                              }
                            ),
                          ),
                        ),
                      ],
                    ),
                    ExpansionTile(
                      initiallyExpanded: true,
                      title: Text('Turn off if'),
                      leading: Icon(Icons.invert_colors_off),
                      children: [
                        BlocBuilder<RulesCubit, RulesState>(
                          buildWhen: (previous, current) => previous.maxMoisture != current.maxMoisture,
                          builder: (context, state) => ListTile(
                            isThreeLine: true,
                            title: Text('${state.maxMoisture?.value ?? '-'} %'),
                            subtitle: Text('Moisture is above ${state.maxMoisture?.value ?? '-'} %'),
                            leading: Icon(Icons.grass, color: GreenHouseColors.black),
                            trailing: IconButton(
                              icon: state.maxMoisture?.value != null ? Icon(Icons.edit) : CircularProgressIndicator(),
                              color: GreenHouseColors.black,
                              onPressed: () async {
                                if (state.maxMoisture != null) {
                                  final value = await showDialog<double>(context: context, builder: (_) => RulesDialog(
                                    title: 'Moisture',
                                    unit: '%',
                                    value: state.maxMoisture.value,
                                    min: 0.0,
                                    max: 100.0,
                                    steps: 50,
                                  ));
                                  if (value != null) {
                                    context.read<RulesCubit>().changeThreshold(state.maxMoisture, value);
                                  }
                                }
                              }
                            ),
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
                margin: EdgeInsets.all(8.0),
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
                          isThreeLine: true,
                          title: Text('Low'),
                          subtitle: Text('Brightness'),
                          leading: Icon(Icons.nights_stay, color: GreenHouseColors.black),
                          // trailing: IconButton(
                          //   icon: Icon(Icons.edit),
                          //   color: GreenHouseColors.black,
                          //   onPressed: () {}
                          // ),
                        ),
                      ],
                    ),
                    ExpansionTile(
                      initiallyExpanded: true,
                      title: Text('Turn off if'),
                      leading: Icon(Icons.invert_colors_off),
                      children: [
                        ListTile(
                          isThreeLine: true,
                          title: Text('High'),
                          subtitle: Text('Brightness'),
                          leading: Icon(Icons.wb_sunny, color: GreenHouseColors.black),
                          // trailing: IconButton(
                          //   icon: Icon(Icons.edit),
                          //   color: GreenHouseColors.black,
                          //   onPressed: () {}
                          // ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
