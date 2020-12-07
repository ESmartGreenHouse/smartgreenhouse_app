part of 'particles_cubit.dart';

abstract class ParticlesState extends Equatable {
  const ParticlesState();

  @override
  List<Object> get props => [];
}

class ParticlesInitial extends ParticlesState {}

class ParticlesLoadInProgress extends ParticlesState {}

class ParticlesLoadSuccess extends ParticlesState {
  final List<Particle> particles;

  ParticlesLoadSuccess(this.particles);

  @override
  List<Object> get props => [particles];
}

class ParticlesLoadFailure extends ParticlesState {
  final String message;

  ParticlesLoadFailure([this.message = 'Failed to load particles']);

  @override
  List<Object> get props => [message];
}
