import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartgreenhouse_app/particles/particles.dart';
import 'package:smartgreenhouse_app/reports_picker/reports_picker.dart';
import 'package:smartgreenhouse_app/theme.dart';

class ReportsPickerSensor extends StatelessWidget {
  const ReportsPickerSensor({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: BlocBuilder<ParticlesCubit, ParticlesState>(
        builder: (context, particlesState) {
          if (particlesState is ParticlesLoadSuccess) {
            return ListView.builder(
              itemCount: particlesState.particles.length,
              itemBuilder: (context, index) {
                final particle = particlesState.particles.elementAt(index);
                return BlocBuilder<ReportsPickerCubit, ReportsPickerState>(
                  builder: (context, reportsState) {
                    return ExpansionTile(
                      title: Text(
                        particle.name,
                        style: reportsState.particle == particle
                          ? TextStyle(fontWeight: FontWeight.bold, color: GreenHouseColors.green)
                          : null
                      ),
                      children: particle.sensors.isNotEmpty
                        ? particle.sensors.map((s) => ListTile(
                            title: Text(s.name),
                            subtitle: Text(s.type.toString()),
                            leading: reportsState.particle == particle && reportsState.sensor == s
                              ? Icon(Icons.radio_button_checked, color: GreenHouseColors.orange)
                              : Icon(Icons.radio_button_unchecked),
                            onTap: () => context.bloc<ReportsPickerCubit>().sensor(particle, s),
                          )).toList()
                        : [ListTile(title: Text('No sensors found'))],
                    );
                  },
                );
              },
            );
          }
          if (particlesState is ParticlesLoadInProgress) {
            return LinearProgressIndicator();
          }
          if (particlesState is ParticlesLoadFailure) {
            return ListTile(
              title: Text(particlesState.message),
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
