import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:greenhouse_repository/greenhouse_repository.dart';
import 'package:meta/meta.dart';

part 'particles_state.dart';

class ParticlesCubit extends Cubit<ParticlesState> {
  final GreenhouseRepository greenhouseRepository;

  ParticlesCubit({
    @required this.greenhouseRepository,
  }) : assert(greenhouseRepository != null),
       super(ParticlesInitial());

  void load() async {
    emit(ParticlesLoadInProgress());

    final result = await greenhouseRepository.getParticles();

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

  void syncParticleCloud() async {
    emit(ParticlesLoadInProgress());
    await greenhouseRepository.syncParticles();
    load();
  }

  void shareParticle(Particle particle, bool share) async {
    emit(ParticlesLoadInProgress());
    await greenhouseRepository.shareParticleData(particle.copyWith(isShared: share));
    load();
  }

  void renameParticle(Particle particle, String name) async {
    emit(ParticlesLoadInProgress());
    await greenhouseRepository.renameParticle(particle.copyWith(name: name));
    syncParticleCloud();
  }

  void changeParticleNotes(Particle particle, String notes) async {
    emit(ParticlesLoadInProgress());
    await greenhouseRepository.changeParticleNotes(particle.copyWith(notes: notes));
    syncParticleCloud();
  }
}
