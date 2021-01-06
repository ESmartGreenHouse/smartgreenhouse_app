import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartgreenhouse_app/authentication/authentication.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: 'Logout',
      icon: const Icon(Icons.exit_to_app),
      onPressed: () => context
        .bloc<AuthenticationBloc>()
        .add(AuthenticationLogoutRequested()),
    );
  }
}
