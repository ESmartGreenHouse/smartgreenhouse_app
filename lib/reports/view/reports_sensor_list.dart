import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartgreenhouse_app/particles/particles.dart';
import 'package:smartgreenhouse_app/reports/reports.dart';
import 'package:smartgreenhouse_app/theme.dart';

class ReportsSensorList extends StatelessWidget {
  const ReportsSensorList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: BlocBuilder<ParticlesCubit, ParticlesState>(
        builder: (context, state) {
          if (state is ParticlesLoadSuccess) {
            return ListView.builder(
              itemCount: state.particles.length,
              itemBuilder: (context, index) {
                final particle = state.particles.elementAt(index);
                return ExpansionTile(
                  leading: Icon(Icons.memory, color: GreenHouseColors.green),
                  title: Text(particle.name),
                  subtitle: BlocBuilder<ReportsCubit, ReportsState>(
                    builder: (context, reportsState) {
                      if (reportsState is ReportsLoadPending) {
                        if (reportsState.particle == particle) {
                          return Text(reportsState.sensor.name);
                        }
                      }
                      if (reportsState is ReportsLoadSuccess) {
                        if (reportsState.particle == particle) {
                          return Text(reportsState.sensor.name);
                        }
                      }
                      return Text('');
                    },
                  ),
                  children: particle.sensors.isNotEmpty
                    ? particle.sensors.map((s) => ListTile(
                        title: Text(s.name),
                        subtitle: Text(s.type.toString()),
                        leading: BlocBuilder<ReportsCubit, ReportsState>(
                          builder: (context, reportsState) {
                            if (reportsState is ReportsLoadPending) {
                              if (reportsState.particle == particle && reportsState.sensor == s) {
                                return Icon(Icons.radio_button_checked, color: GreenHouseColors.orange);
                              }
                            }
                            if (reportsState is ReportsLoadSuccess) {
                              if (reportsState.particle == particle && reportsState.sensor == s) {
                                return Icon(Icons.radio_button_checked, color: GreenHouseColors.orange);
                              }
                            }
                            return Icon(Icons.radio_button_unchecked);
                          },
                        ),
                        onTap: () => context.bloc<ReportsCubit>().sensor(particle, s),
                      )).toList()
                    : [ListTile(title: Text('No sensors found'))],
                );
              },
            );
          }
          if (state is ParticlesLoadInProgress) {
            return LinearProgressIndicator();
          }
          if (state is ParticlesLoadFailure) {
            return ListTile(
              title: Text(state.message),
              leading: Icon(Icons.error, color: GreenHouseColors.orange),
            );
          }
          return ListTile(
            title: Text('Unknown state'),
            leading: Icon(Icons.error, color: GreenHouseColors.orange),
          );
        },
      ),
    );
  }
}
