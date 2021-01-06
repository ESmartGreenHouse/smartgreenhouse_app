import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:smartgreenhouse_app/authentication/authentication.dart';
import 'package:formz/formz.dart';
import 'package:smartgreenhouse_app/particle_cloud/particle_cloud.dart';

part 'particle_cloud_state.dart';

class ParticleCloudCubit extends Cubit<ParticleCloudState> {
  ParticleCloudCubit({
    @required this.authenticationRepository,
    bool isLinked = false,
  }) : assert(authenticationRepository != null),
       super(ParticleCloudState(isLinked: isLinked));

  final AuthenticationRepository authenticationRepository;

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(state.copyWith(
      email: email,
      status: Formz.validate([
        email,
        state.password,
        state.clientId,
        state.clientSecret,
      ]),
    ));
  }

  void passwordChanged(String value) {
    final password = CloudPassword.dirty(value);
    emit(state.copyWith(
      password: password,
      status: Formz.validate([
        state.email,
        password,
        state.clientId,
        state.clientSecret,
      ]),
    ));
  }

  void clientIdChanged(String value) {
    final clientId = ClientId.dirty(value);
    emit(state.copyWith(
      clientId: clientId,
      status: Formz.validate([
        state.email,
        state.password,
        clientId,
        state.clientSecret,
      ]),
    ));
  }

  void clientSecretChanged(String value) {
    final clientSecret = ClientSecret.dirty(value);
    emit(state.copyWith(
      clientSecret: clientSecret,
      status: Formz.validate([
        state.email,
        state.password,
        state.clientId,
        clientSecret,
      ]),
    ));
  }

  Future<void> link() async {
    if (!state.status.isValidated) return;

    emit(state.copyWith(status: FormzStatus.submissionInProgress));

    try {
      await authenticationRepository.link(
        email: state.email.value,
        password: state.password.value,
        id: state.clientId.value,
        secret: state.clientSecret.value,
      );

      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on Exception {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }

  Future<void> unlink() async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await authenticationRepository.unlink();
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } catch(e) {
      print(e);
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
