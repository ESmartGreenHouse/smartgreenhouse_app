part of 'particle_cloud_cubit.dart';

class ParticleCloudState extends Equatable {
  final bool isLinked;

  final Email email;
  final CloudPassword password;
  final ClientId clientId;
  final ClientSecret clientSecret;
  final FormzStatus status;

  const ParticleCloudState({
    this.isLinked = false,
    this.email = const Email.pure(),
    this.password = const CloudPassword.pure(),
    this.clientId = const ClientId.pure(),
    this.clientSecret = const ClientSecret.pure(),
    this.status = FormzStatus.pure,
  });

  @override
  List<Object> get props => [isLinked, email, password, clientId, clientSecret, status];

  ParticleCloudState copyWith({
    Email email,
    CloudPassword password,
    ClientId clientId,
    ClientSecret clientSecret,
    FormzStatus status,
  }) {
    return ParticleCloudState(
      isLinked: isLinked,
      email: email ?? this.email,
      password: password ?? this.password,
      clientId: clientId ?? this.clientId,
      clientSecret: clientSecret ?? this.clientSecret,
      status: status ?? this.status,
    );
  }
}
