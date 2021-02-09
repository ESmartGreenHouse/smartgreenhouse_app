import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartgreenhouse_app/app_router.dart';
import 'package:smartgreenhouse_app/authentication/authentication.dart';
import 'package:smartgreenhouse_app/theme.dart';

class ParticleCloudTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state.user.isCloudLinked) {
          return ListTile(
            title: Text('Particle Cloud'),
            subtitle: Text('Linked'),
            leading: Icon(Icons.cloud, color: GreenHouseColors.blue),
            trailing: Icon(Icons.chevron_right),
            onTap: () => Navigator.pushNamed(context, AppRoutes.particleCloud, arguments: true),
          );
        }
        return ListTile(
          title: Text('Particle Cloud'),
          subtitle: Text('Not Linked'),
          leading: Icon(Icons.cloud, color: GreenHouseColors.black),
          trailing: Icon(Icons.chevron_right),
          onTap: () => Navigator.pushNamed(context, AppRoutes.particleCloud, arguments: false),
        );
      },
    );
  }
}
