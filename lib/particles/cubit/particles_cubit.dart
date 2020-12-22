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
        emit(ParticlesLoadFailure('No particles found'))
;      }
    } else {
      emit(ParticlesLoadFailure());
    }
  }
}
