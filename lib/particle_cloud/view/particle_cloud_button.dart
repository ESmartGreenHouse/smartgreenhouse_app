import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartgreenhouse_app/authentication/authentication.dart';
import 'package:smartgreenhouse_app/particle_cloud/particle_cloud.dart';

class ParticleCloudButton extends StatelessWidget {
  const ParticleCloudButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state.user.isCloudLinked) {
          return IconButton(
            tooltip: 'Remove Particle Cloud link',
            icon: Icon(Icons.cloud),
            onPressed: () => Navigator.of(context).push(ParticleCloudPage.route(isLinked: true)),
          );
        }
        return IconButton(
          tooltip: 'Link Particle Cloud',
          icon: Icon(Icons.cloud_off),
          onPressed: () => Navigator.of(context).push(ParticleCloudPage.route(isLinked: false)),
        );
      },
    );
  }
}
