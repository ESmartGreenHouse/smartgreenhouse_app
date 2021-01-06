import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:smartgreenhouse_app/authentication/bloc/authentication_bloc.dart';
import 'package:smartgreenhouse_app/particle_cloud/particle_cloud.dart';
import 'package:formz/formz.dart';
import 'package:smartgreenhouse_app/theme.dart';

class ParticleCloudForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final passwordFocusNode = FocusNode();
    final clientIdFocusNode = FocusNode();
    final clientSecretFocusNode = FocusNode();

    return BlocListener<ParticleCloudCubit, ParticleCloudState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(state.isLinked ? 'Account unlink Failure' : 'Account link Failure')));
        }
        if (state.status.isSubmissionSuccess) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(state.isLinked ? 'Account unlinked' : 'Account linked')));
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
                    _PasswordInput(passwordFocusNode, clientIdFocusNode),
                    const SizedBox(height: 8.0),
                    _ClientIdInput(clientIdFocusNode, clientSecretFocusNode),
                    const SizedBox(height: 8.0),
                    _ClientSecretInput(clientSecretFocusNode),
                    const SizedBox(height: 32.0),
                    _ParticleCloudButton(),
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
    return BlocBuilder<ParticleCloudCubit, ParticleCloudState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          autocorrect: true,
          autofocus: true,
          enabled: !state.isLinked,
          onChanged: (email) => context.bloc<ParticleCloudCubit>().emailChanged(email),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: 'Particle Cloud Email',
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
  final FocusNode nextFocusNode;

  _PasswordInput(this.focusNode, this.nextFocusNode);


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ParticleCloudCubit, ParticleCloudState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          enabled: !state.isLinked,
          onChanged: (password) => context.bloc<ParticleCloudCubit>().passwordChanged(password),
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Particle Cloud Password',
            helperText: '',
            errorText: state.password.invalid ? 'Invalid password' : null,
          ),
          onSubmitted: (_) => nextFocusNode.requestFocus(),
          focusNode: focusNode,
        );
      },
    );
  }
}

class _ClientIdInput extends StatelessWidget {
  final FocusNode focusNode;
  final FocusNode nextFocusNode;

  _ClientIdInput(this.focusNode, this.nextFocusNode);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ParticleCloudCubit, ParticleCloudState>(
      buildWhen: (previous, current) => previous.clientId != current.clientId,
      builder: (context, state) {
        return TextField(
          enabled: !state.isLinked,
          onChanged: (id) => context.bloc<ParticleCloudCubit>().clientIdChanged(id),
          decoration: InputDecoration(
            labelText: 'Client ID',
            hintText: 'isd-smartgreenhouse',
            helperText: '',
            errorText: state.clientId.invalid ? 'Invalid client ID' : null,
          ),
          onSubmitted: (_) => nextFocusNode.requestFocus(),
          focusNode: focusNode,
        );
      },
    );
  }
}

class _ClientSecretInput extends StatelessWidget {
  final FocusNode focusNode;

  _ClientSecretInput(this.focusNode);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ParticleCloudCubit, ParticleCloudState>(
      buildWhen: (previous, current) => previous.clientSecret != current.clientSecret,
      builder: (context, state) {
        return TextField(
          enabled: !state.isLinked,
          onChanged: (secret) => context.bloc<ParticleCloudCubit>().clientSecretChanged(secret),
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Client Secret',
            helperText: '',
            errorText: state.clientSecret.invalid ? 'Invalid client secret' : null,
          ),
          onSubmitted: (_) => state.status.isValidated
            ? (_) => context.bloc<ParticleCloudCubit>().link()
            : null,
        );
      },
    );
  }
}

class _ParticleCloudButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ParticleCloudCubit, ParticleCloudState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
          ? const CircularProgressIndicator()
          : RaisedButton(
              child: Text(
                context.bloc<AuthenticationBloc>().state.user.isCloudLinked ? 'UNLINK' : 'LINK',
                style: TextStyle(color: Colors.white),
              ),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
              padding: EdgeInsets.all(16),
              color: GreenHouseColors.blue,
              disabledColor: GreenHouseColors.black,
              onPressed: state.status == FormzStatus.submissionSuccess
                ? null
                : context.bloc<AuthenticationBloc>().state.user.isCloudLinked
                  ? () => context.bloc<ParticleCloudCubit>().unlink()
                  : state.status.isValidated
                    ? () => context.bloc<ParticleCloudCubit>().link()
                    : null
            );
      },
    );
  }
}
