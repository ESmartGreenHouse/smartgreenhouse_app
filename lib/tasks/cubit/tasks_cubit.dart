import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:greenhouse_repository/greenhouse_repository.dart';
import 'package:meta/meta.dart';

part 'tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {
  final GreenhouseRepository greenhouseRepository;

  TasksCubit({@required this.greenhouseRepository}) 
   : assert(greenhouseRepository != null),
     super(TasksInitial());

  void load() async {
    emit(TasksLoadInProgress());

    final result = await greenhouseRepository.getTasks();

    if (result != null) {
      if (result.isNotEmpty) {
        emit(TasksLoadSuccess(result));
      } else {
        emit(TasksLoadFailure('No tasks found'));
      }
    } else {
      emit(TasksLoadFailure());
    }
  }
}
