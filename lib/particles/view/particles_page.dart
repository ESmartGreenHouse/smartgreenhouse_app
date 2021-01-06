import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_scaffold/templates/layout/scaffold.dart';
import 'package:smartgreenhouse_app/authentication/authentication.dart';
import 'package:smartgreenhouse_app/logout/logout.dart';
import 'package:smartgreenhouse_app/menu/menu.dart';
import 'package:smartgreenhouse_app/particle_cloud/particle_cloud.dart';
import 'package:smartgreenhouse_app/particles/particles.dart';
import 'package:smartgreenhouse_app/theme.dart';

class ParticlesPage extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  static Route route() {
    return PageRouteBuilder<MaterialPageRoute<void>>(
      pageBuilder: (_, __, ___) => ParticlesPage(),
      transitionDuration: Duration(seconds: 0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaffold(
      scaffoldKey: _scaffoldKey,
      title: Text('Particles'),
      drawer: AppDrawer(),
      trailing: Row(
        children: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () => context.bloc<ParticlesCubit>().load(),
          ),
          IconButton(
            icon: Icon(context.bloc<AuthenticationBloc>().state.user.isCloudLinked ? Icons.sync : Icons.sync_disabled),
            disabledColor: GreenHouseColors.orange,
            onPressed: context.bloc<AuthenticationBloc>().state.user.isCloudLinked ? () => context.bloc<ParticlesCubit>().syncParticleCloud() : null,
          ),
          ParticleCloudButton(),
          LogoutButton(),
        ],
      ),
      body: BlocBuilder<ParticlesCubit, ParticlesState>(
        builder: (context, state) {
          if (state is ParticlesLoadSuccess) {
            return ListView.builder(
              itemCount: state.particles.length,
              itemBuilder: (context, index) {
                final particle = state.particles.elementAt(index);
                return Card(
                  margin: EdgeInsets.fromLTRB(32.0, 8.0, 32.0, 8.0),
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
                      ),
                      ListTile(
                        leading: Icon(Icons.notes, color: GreenHouseColors.black),
                        title: Text(particle.notes),
                        subtitle: Text('Notes'),
                      ),
                      Divider(),
                      ListTile(
                        leading: Icon(particle.isShared ? Icons.check_box : Icons.check_box_outline_blank, color: particle.isOwned ? GreenHouseColors.green : GreenHouseColors.black),
                        title: Text('Share Particle data'),
                        subtitle: particle.isOwned ? null : Text('You can only share data of your own Particles'),
                        onTap: particle.isOwned ? () => context.bloc<ParticlesCubit>().shareParticle(particle, !particle.isShared) : null,
                      ),
                      Divider(),
                      ListTile(
                        title: Text('Sensors', style: TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text(particle.sensors.isNotEmpty ? particle.sensors.map<String>((e) => e.name.toString()).toList().join(', ') : 'No sensors found'),
                      ),
                    ],
                  ),
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
