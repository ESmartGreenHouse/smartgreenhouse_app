import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greenhouse_repository/greenhouse_repository.dart';
import 'package:smartgreenhouse_app/common/text_dialog.dart';
import 'package:smartgreenhouse_app/particles/cubit/particles_cubit.dart';
import 'package:smartgreenhouse_app/theme.dart';

class ParticleCard extends StatelessWidget {
  final Particle particle;

  const ParticleCard({@required this.particle});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Column(
        children: [
          ListTile(
            leading: particle.isOwned ? Icon(Icons.person, color: GreenHouseColors.green) : Icon(Icons.person_outline, color: GreenHouseColors.black),
            title: Text(particle.isOwned ? 'Owned' : 'Shared'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.memory, color: GreenHouseColors.green),
            title: Text(particle.name),
            subtitle: Text(particle.id),
            trailing: particle.isOwned ? IconButton(
              icon: Icon(Icons.edit, color: GreenHouseColors.green),
              onPressed: () async {
                final result = await showDialog<String>(context: context, builder: (_) => TextDialog(
                  title: 'Rename Particle',
                  label: 'Name',
                  hint: particle.name,
                  initalValue: particle.name,
                ));
                if (result != null) {
                  context.bloc<ParticlesCubit>().renameParticle(particle, result);
                }
              },
            ) : null,
          ),
          ListTile(
            leading: Icon(Icons.notes, color: GreenHouseColors.black),
            title: Text(particle.notes),
            subtitle: Text('Notes'),
            trailing: particle.isOwned ? IconButton(
              icon: Icon(Icons.edit, color: GreenHouseColors.green),
              onPressed: () async {
                final result = await showDialog<String>(context: context, builder: (_) => TextDialog(
                  title: 'Particle Notes',
                  label: 'Note',
                  hint: particle.notes,
                  initalValue: particle.notes,
                ));
                if (result != null) {
                  context.bloc<ParticlesCubit>().changeParticleNotes(particle, result);
                }
              },
            ) : null,
          ),
          Divider(),
          ListTile(
            leading: Icon(particle.isShared ? Icons.check_box : Icons.check_box_outline_blank, color: particle.isOwned ? GreenHouseColors.green : GreenHouseColors.black),
            title: Text('Share Particle data'),
            subtitle: particle.isOwned ? Text('Data of your Particle is shared with every logged in User') : Text('You can only share data of your own Particles'),
            onTap: particle.isOwned ? () => context.bloc<ParticlesCubit>().shareParticle(particle, !particle.isShared) : null,
          ),
          Divider(),
          ListTile(
            title: Text('Sensors', style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(particle.sensors.isNotEmpty ? particle.sensors.map<String>((e) => e.name.toString()).toList().join(', ') : 'No sensors found'),
          ),
          ListTile(
            title: Text('Actuators', style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(particle.actuators.isNotEmpty ? particle.actuators.map<String>((e) => e.name.toString()).toList().join(', ') : 'No actuators found'),
          ),
          ListTile(
            title: Text('Thresholds', style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(particle.thresholds.isNotEmpty ? particle.thresholds.map<String>((e) => e.name.toString()).toList().join(', ') : 'No thresholds found'),
          ),
        ],
      ),
    );
  }
}
