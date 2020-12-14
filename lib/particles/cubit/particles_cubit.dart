import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:greenhouse_repository/greenhouse_repository.dart';
import 'package:meta/meta.dart';

part 'particles_state.dart';

class ParticlesCubit extends Cubit<ParticlesState> {
  final GreenhouseRepository greenhouseRepository;

  ParticlesCubit({@required this.greenhouseRepository}) 
    : assert(greenhouseRepository != null),
      super(ParticlesInitial());

  void load() async {
    emit(ParticlesLoadInProgress());

    final result = await greenhouseRepository.getParticles();

    if (result != null) {
      if (result.isNotEmpty) {
        emit(ParticlesLoadSuccess(result));
      } else {
        emit(ParticlesLoadFailure('No particles found'))
;      }
    } else {
      emit(ParticlesLoadFailure());
    }
  }
}
