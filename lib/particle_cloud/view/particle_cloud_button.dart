import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartgreenhouse_app/app_router.dart';
import 'package:smartgreenhouse_app/authentication/authentication.dart';

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
            onPressed: () => Navigator.pushNamed(context, AppRoutes.particleCloud, arguments: true),
          );
        }
        return IconButton(
          tooltip: 'Link Particle Cloud',
          icon: Icon(Icons.cloud_off),
          onPressed: () => Navigator.pushNamed(context, AppRoutes.particleCloud, arguments: false),
        );
      },
    );
  }
}
