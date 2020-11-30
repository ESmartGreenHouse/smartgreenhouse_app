import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartgreenhouse_app/login/login.dart';
import 'package:smartgreenhouse_app/theme.dart';

class LoginPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GreenHouseColors.green,      
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('/images/greenhouse.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: BlocProvider(
          create: (_) => LoginCubit(
            context.repository<AuthenticationRepository>(),
          ),
          child: LoginForm(),
        ),
      ),            
    );
  }
}
