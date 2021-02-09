import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greenhouse_repository/greenhouse_repository.dart';
import 'package:smartgreenhouse_app/authentication/authentication.dart';
import 'package:smartgreenhouse_app/common/custom_grid.dart';
import 'package:smartgreenhouse_app/menu/menu.dart';
import 'package:smartgreenhouse_app/particles/particles.dart';
import 'package:smartgreenhouse_app/theme.dart';

class ParticlesPage extends StatelessWidget {

  static Route route() {
    return PageRouteBuilder<MaterialPageRoute<void>>(
      pageBuilder: (_, __, ___) => ParticlesPage(),
      transitionDuration: Duration(seconds: 0),
    );
  }

  int _columnCount(Size size) {
    if (size.width > 2000) return 4;
    if (size.width > 1500) return 3;
    if (size.width > 1000) return 2;
    return 1;
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
            onPressed: () {
              if (context.bloc<AuthenticationBloc>().state.user.isCloudLinked) {
                context.bloc<ParticlesCubit>().syncParticleCloud();
              } else {
                context.bloc<ParticlesCubit>().load();
              }
            }
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: BlocBuilder<ParticlesCubit, ParticlesState>(
        builder: (context, state) {
          if (state is ParticlesLoadSuccess) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomGrid(
                  columnCount: _columnCount(MediaQuery.of(context).size),
                  children: state.particles.map((p) => ParticleCard(particle: p)).toList(),
                ),
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
}
