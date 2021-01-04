import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_scaffold/templates/layout/scaffold.dart';
import 'package:smartgreenhouse_app/authentication/authentication.dart';
import 'package:smartgreenhouse_app/logout/logout.dart';
import 'package:smartgreenhouse_app/menu/menu.dart';
import 'package:smartgreenhouse_app/particles/particles.dart';
import 'package:smartgreenhouse_app/particles_dialog/particles_dialog.dart';
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
                return ExpansionTile(
                  leading: Icon(Icons.memory, color: GreenHouseColors.green),
                  title: Text(particle.name),
                  subtitle: Text(particle.description),
                  children: [
                    Divider(),
                    ...(particle.ownerUid == context.bloc<AuthenticationBloc>().state.user.id ? [
                      ListTile(
                        title: Text('Delete Particle'),
                        leading: IconButton(
                          icon: Icon(Icons.delete, color: GreenHouseColors.black),
                          onPressed: () async {
                            final result = await showDialog(context: context, builder: (context) => AlertDialog(
                              title: Text('Delete Particle'),
                              content: Text('Are you sure, you want to delete ${particle.name}?'),
                              actions: [
                                FlatButton(child: Text('No', style: TextStyle(color: GreenHouseColors.orange)), onPressed: () => Navigator.of(context).pop(false)),
                                FlatButton(child: Text('Yes', style: TextStyle(color: GreenHouseColors.orange)), onPressed: () => Navigator.of(context).pop(true)),
                              ],
                            ));
                            if (result == true) context.bloc<ParticlesCubit>().deleteParticle(particle);
                          },
                        ),
                      ),
                      Divider(),
                    ] : [Container()]),
                    ...(particle.writeUids.contains(context.bloc<AuthenticationBloc>().state.user.id) ? [
                      ListTile(
                        title: Text('Edit name and description'),
                        leading: IconButton(
                          icon: Icon(Icons.edit, color: GreenHouseColors.black),
                          onPressed: () async {
                            final result = await showDialog(context: context, builder: (_) => ParticlesDialog(
                              name: particle.name,
                              description: particle.description,
                              id: particle.id,
                            ));
                            if (result == true) context.bloc<ParticlesCubit>().load();
                            if (result == false) {
                              _scaffoldKey.currentState
                                ..hideCurrentSnackBar()
                                ..showSnackBar(
                                  const SnackBar(content: Text('Failed to edit Particle')),
                                );
                            }
                          },
                        ),
                      ),
                      Divider(),
                    ] : [Container()]),
                    particle.sensors.isNotEmpty
                      ? ListTile(
                          title: Text('Sensors', style: TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text(particle.sensors.map<String>((e) => e.name.toString()).toList().join(', ')),
                        )
                      : ListTile(title: Text('Sensors', style: TextStyle(fontWeight: FontWeight.bold)), subtitle: Text('No sensors found')),
                      Divider(),
                      ListTile(
                        title: Text('Read', style: TextStyle(fontWeight: FontWeight.bold)),
                        leading: context.bloc<AuthenticationBloc>().state.user.id == particle.ownerUid ? IconButton(
                          icon: Icon(Icons.add_circle_outline),
                          color: GreenHouseColors.black,
                          onPressed: () async {
                            final value = await showDialog<String>(context: context, builder: (context) => UidDialog());
                            context.bloc<ParticlesCubit>().addReadUser(particle, value);
                          },
                        ) : null,
                      ),
                      ...particle.readUids.map<ListTile>((e) => ListTile(
                        title: Text(e),
                        leading: context.bloc<AuthenticationBloc>().state.user.id == particle.ownerUid ? IconButton(
                          icon: Icon(Icons.delete),
                          color: GreenHouseColors.black,
                          onPressed: () => context.bloc<ParticlesCubit>().removeReadUser(particle, e),
                        ) : null,
                      )).toList(),
                      Divider(),
                      ListTile(
                        title: Text('Write', style: TextStyle(fontWeight: FontWeight.bold)),
                        leading: context.bloc<AuthenticationBloc>().state.user.id == particle.ownerUid ? IconButton(
                          icon: Icon(Icons.add_circle_outline),
                          color: GreenHouseColors.black,
                          onPressed: () async {
                            final value = await showDialog<String>(context: context, builder: (_) => UidDialog());
                            context.bloc<ParticlesCubit>().addWriteUser(particle, value);
                          },
                        ) : null,
                      ),
                      ...particle.writeUids.map<ListTile>((e) => ListTile(
                        title: Text(e),
                        leading: context.bloc<AuthenticationBloc>().state.user.id == particle.ownerUid ? IconButton(
                          icon: Icon(Icons.delete),
                          color: GreenHouseColors.black,
                          onPressed: () => context.bloc<ParticlesCubit>().removeWriteUser(particle, e),
                        ) : null,
                      )).toList(),
                  ],
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).accentColor,
        onPressed: () async {
          final result = await showDialog(context: context, builder: (_) => ParticlesDialog());
          if (result == true) context.bloc<ParticlesCubit>().load();
          if (result == false) {
            _scaffoldKey.currentState
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(content: Text('Failed to add particle. Particles could only be added by admins during devlopment.')),
              );
          }
        },
      ),
    );
  }
}
