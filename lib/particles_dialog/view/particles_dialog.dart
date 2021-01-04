import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:greenhouse_repository/greenhouse_repository.dart';
import 'package:smartgreenhouse_app/authentication/authentication.dart';
import 'package:smartgreenhouse_app/particles_dialog/particles_dialog.dart';

class ParticlesDialog extends StatelessWidget {
  final String id;
  final String name;
  final String description;

  ParticlesDialog({
    this.id,
    this.name,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ParticlesDialogCubit(
        greenhouseRepository: context.repository<GreenhouseRepository>(),
        authenticationBloc: context.bloc<AuthenticationBloc>(),
        name: name,
        description: description,
        id: id,
      ),
      child: _Dialog(),
    );
  }
}

class _Dialog extends StatelessWidget {
  const _Dialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<ParticlesDialogCubit, ParticlesDialogState>(
      listener: (context, state) {
        if (state.status == FormzStatus.submissionSuccess) {
          Navigator.of(context).pop(true);
        }
      },
      child: SimpleDialog(
        title: Text('Particle'),
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: BlocBuilder<ParticlesDialogCubit, ParticlesDialogState>(
              buildWhen: (previous, current) => previous.name != current.name,
              builder: (context, state) {
                return TextFormField(
                  autofocus: true,
                  initialValue: state.name.value ?? '',
                  onChanged: (value) => context.bloc<ParticlesDialogCubit>().nameChanged(value),
                  decoration: InputDecoration(
                    labelText: 'Name',
                    hintText: 'MyAwesomeParticle',
                    errorText: state.name.invalid ? 'Please enter Particle name' : null,
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: BlocBuilder<ParticlesDialogCubit, ParticlesDialogState>(
              buildWhen: (previous, current) => previous.description != current.description,
              builder: (context, state) {
                return TextFormField(
                  initialValue: state.description.value ?? '',
                  onChanged: (value) => context.bloc<ParticlesDialogCubit>().descriptionChanged(value),
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    hintText: 'This is an awesome Particle',
                    errorText: state.description.invalid ? 'Please enter Particle description' : null,
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: BlocBuilder<ParticlesDialogCubit, ParticlesDialogState>(
              buildWhen: (previous, current) => previous.mac != current.mac,
              builder: (context, state) {
                return TextField(
                  onChanged: (value) => context.bloc<ParticlesDialogCubit>().macChanged(value),
                  enabled: state.id == null,
                  decoration: InputDecoration(
                    labelText: state.id == null ? 'MAC' : 'ID',
                    hintText: '00:80:41:ae:fd:7e',
                    errorText: state.mac.invalid ? 'Please enter Particle MAC address' : null,
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FlatButton(
                  child: Text('CANCEL', style: TextStyle(color: Theme.of(context).primaryColor)),
                  onPressed: () => Navigator.of(context).pop(false),
                ),
                FlatButton(
                  child: Text('OK', style: TextStyle(color: Theme.of(context).primaryColor)),
                  onPressed: () => context.bloc<ParticlesDialogCubit>().submit(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
