import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:greenhouse_repository/greenhouse_repository.dart';
import 'package:meta/meta.dart';
import 'package:smartgreenhouse_app/authentication/bloc/authentication_bloc.dart';

part 'particles_state.dart';

class ParticlesCubit extends Cubit<ParticlesState> {
  final GreenhouseRepository greenhouseRepository;
  final AuthenticationBloc authenticationBloc;

  ParticlesCubit({
    @required this.greenhouseRepository,
    @required this.authenticationBloc,
  }) : assert(greenhouseRepository != null),
       assert(authenticationBloc != null),
       super(ParticlesInitial());

  void load() async {
    emit(ParticlesLoadInProgress());

    final result = await greenhouseRepository.getParticles(authenticationBloc.state.user.id);

    if (result != null) {
      if (result.isNotEmpty) {
        emit(ParticlesLoadSuccess(result));
      } else {
        emit(ParticlesLoadFailure('No particles found'));
      }
    } else {
      emit(ParticlesLoadFailure());
    }
  }

  void addReadUser(Particle particle, String uuid) async {
    await greenhouseRepository.addOrUpdateParticle(particle.copyWith(readUids: particle.readUids..add(uuid)));
    load();
  }

  void removeReadUser(Particle particle, String uuid) async {
    await greenhouseRepository.addOrUpdateParticle(particle.copyWith(readUids: particle.readUids..removeWhere((u) => u == uuid)));
    load();
  }

  void addWriteUser(Particle particle, String uuid) async {
    await greenhouseRepository.addOrUpdateParticle(particle.copyWith(writeUids: particle.writeUids..add(uuid)));
    load();
  }

  void removeWriteUser(Particle particle, String uuid) async {
    await greenhouseRepository.addOrUpdateParticle(particle.copyWith(writeUids: particle.writeUids..removeWhere((u) => u == uuid)));
    load();
  }
}
