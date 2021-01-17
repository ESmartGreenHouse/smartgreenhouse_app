import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartgreenhouse_app/authentication/authentication.dart';

class LogoutButton extends StatelessWidget {
  final Color color;

  const LogoutButton({Key key, this.color = Colors.white}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: 'Logout',
      icon: Icon(Icons.exit_to_app),
      color: color,
      onPressed: () => context
        .bloc<AuthenticationBloc>()
        .add(AuthenticationLogoutRequested()),
    );
  }
}
