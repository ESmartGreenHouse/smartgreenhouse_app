import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greenhouse_repository/greenhouse_repository.dart';
import 'package:smartgreenhouse_app/authentication/authentication.dart';
import 'package:smartgreenhouse_app/menu/menu.dart';
import 'package:smartgreenhouse_app/particle_cloud/particle_cloud.dart';
import 'package:smartgreenhouse_app/particles/particles.dart';
import 'package:smartgreenhouse_app/theme.dart';

class ParticlesPage extends StatelessWidget {

  static Route route() {
    return PageRouteBuilder<MaterialPageRoute<void>>(
      pageBuilder: (_, __, ___) => ParticlesPage(),
      transitionDuration: Duration(seconds: 0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Particles'),
        actions: [
          IconButton(
            tooltip: 'Refresh Particles',
            icon: Icon(Icons.refresh),
            onPressed: () => context.bloc<ParticlesCubit>().load(),
          ),
          IconButton(
            tooltip: 'Synchronize Particles',
            icon: Icon(context.bloc<AuthenticationBloc>().state.user.isCloudLinked ? Icons.sync : Icons.sync_disabled),
            disabledColor: GreenHouseColors.orange,
            onPressed: context.bloc<AuthenticationBloc>().state.user.isCloudLinked ? () => context.bloc<ParticlesCubit>().syncParticleCloud() : null,
          ),
          ParticleCloudButton(),
        ],
      ),
      drawer: AppDrawer(),
      body: BlocBuilder<ParticlesCubit, ParticlesState>(
        builder: (context, state) {
          if (state is ParticlesLoadSuccess) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: _particleCards(state.particles, MediaQuery.of(context).size.width > 1000 ? 2 : 1),
              ),
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

  List<Widget> _particleCards(List<Particle> particles, [int columnCount = 1]) {
    final result = <Widget>[];

    for (int i = 0; i < particles.length; i = i + columnCount) {
      if (columnCount == 1) {
        result.add(ParticleCard(particle: particles.elementAt(i)));
      } else {
        final row = <Widget>[];

        for (int j = 0; j < columnCount; j++) {
          if ((i + j) < particles.length) {
            row.add(Flexible(child: ParticleCard(particle: particles.elementAt(i + j))));
          }
        }

        result.add(Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: row,
        ));
      }
    }

    return result;
  }
}
