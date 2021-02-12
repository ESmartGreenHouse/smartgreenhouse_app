import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartgreenhouse_app/particle_cloud/particle_cloud.dart';
import 'package:smartgreenhouse_app/theme.dart';

class ParticleCloudPage extends StatelessWidget {
  final bool isLinked;

  ParticleCloudPage({@required this.isLinked});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(primaryColor: GreenHouseColors.blue),
      child: Scaffold(
        backgroundColor: GreenHouseColors.blue,
        appBar: AppBar(
          title: Text('Particle Cloud'),
          backgroundColor: GreenHouseColors.blue,
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/cloud.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: BlocProvider(
            create: (_) => ParticleCloudCubit(
              authenticationRepository: context.repository<AuthenticationRepository>(),
              isLinked: isLinked,
            ),
            child: ParticleCloudForm(),
          ),
        ),
      ),
    );
  }
}
