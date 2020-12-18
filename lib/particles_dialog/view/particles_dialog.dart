import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartgreenhouse_app/particles_dialog/particles_dialog.dart';

class ParticlesDialog extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ParticlesDialogCubit(),
      child: _Dialog(),
    );
  }
}

class _Dialog extends StatelessWidget {
  const _Dialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text('Particle'),
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 25, right: 25),
          child: BlocBuilder<ParticlesDialogCubit, ParticlesDialogState>(
            buildWhen: (previous, current) => previous.name != current.name,
            builder: (context, state) {
              return TextField(
                autofocus: true,
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
              return TextField(
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
                decoration: InputDecoration(
                  labelText: 'MAC',
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
                onPressed: () => Navigator.of(context).pop(),
              ),
              FlatButton(
                child: Text('OK', style: TextStyle(color: Theme.of(context).primaryColor)),
                onPressed: () => context.bloc<ParticlesDialogCubit>().submit(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
