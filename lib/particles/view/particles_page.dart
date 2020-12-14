import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_scaffold/templates/layout/scaffold.dart';
import 'package:smartgreenhouse_app/logout/logout.dart';
import 'package:smartgreenhouse_app/menu/menu.dart';
import 'package:smartgreenhouse_app/particles/particles.dart';
import 'package:smartgreenhouse_app/theme.dart';

class ParticlesPage extends StatelessWidget {
  const ParticlesPage({Key key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => ParticlesPage());
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaffold(
      title: Text('Particles'),
      drawer: AppDrawer(),
      trailing: LogoutButton(),
      body: BlocBuilder<ParticlesCubit, ParticlesState>(
        builder: (context, state) {
          if (state is ParticlesLoadSuccess) {
            return ListView.separated(
              itemCount: state.particles.length,
              itemBuilder: (context, index) {
                final particle = state.particles.elementAt(index);
                return ExpansionTile(
                  leading: Icon(Icons.memory, color: GreenHouseColors.green),
                  title: Text(particle.name),
                  subtitle: Text(particle.description),
                  children: particle.sensors.isNotEmpty
                    ? particle.sensors.map((s) => ListTile(title: Text(s.name), subtitle: Text(s.type.toString()))).toList()
                    : [ListTile(title: Text('No sensors found'))],
                );
              },
              separatorBuilder: (_, __) => Divider(),
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
      )
    );
  }
}
