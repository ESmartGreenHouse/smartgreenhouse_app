import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:smartgreenhouse_app/login/login.dart';
import 'package:smartgreenhouse_app/sign_up/sign_up.dart';
import 'package:formz/formz.dart';
import 'package:smartgreenhouse_app/theme.dart';

class LoginForm extends StatelessWidget {  
  @override
  Widget build(BuildContext context) {
    final passwordFocusNode = FocusNode();

    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Authentication Failure')),
            );
        }
      },
      child: Center(
        child: SingleChildScrollView(
          child: Card(
            margin: EdgeInsets.all(32.0),
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Container(
                width: 400,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 16.0),
                    _EmailInput(passwordFocusNode),
                    const SizedBox(height: 8.0),
                    _PasswordInput(passwordFocusNode),
                    const SizedBox(height: 32.0),
                    _LoginButton(),
                    const SizedBox(height: 16.0),
                    _SignUpButton(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  final FocusNode nextFocusNode;

  _EmailInput(this.nextFocusNode);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          autocorrect: true,
          onChanged: (email) => context.bloc<LoginCubit>().emailChanged(email),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: 'Email',
            hintText: 'max.mustermann@mail.de',
            helperText: '',
            errorText: state.email.invalid ? 'Invalid email' : null,
          ),
          onSubmitted: (_) => nextFocusNode.requestFocus(),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  final FocusNode focusNode;

  _PasswordInput(this.focusNode);


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          onChanged: (password) => context.bloc<LoginCubit>().passwordChanged(password),
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Password',
            helperText: 'Please enter password',
            errorText: state.password.invalid ? 'Invalid password' : null,
          ),
          onSubmitted: state.status.isValidated
            ? (_) => context.bloc<LoginCubit>().logInWithCredentials()
            : null,
          focusNode: focusNode,
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : RaisedButton(
                child: const Text('LOGIN', style: TextStyle(color: Colors.white)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                padding: EdgeInsets.all(16),
                color: GreenHouseColors.green,
                disabledColor: GreenHouseColors.black,
                onPressed: state.status.isValidated
                    ? () => context.bloc<LoginCubit>().logInWithCredentials()
                    : null,
              );
      },
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FlatButton(
      child: Text(
        'CREATE ACCOUNT',
        style: TextStyle(color: theme.primaryColor),
      ),
      onPressed: () => Scaffold.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text('Account creation is currently deactivated, please contact the ISD SmartGreenHouse team.'),)),
    );
  }
}
