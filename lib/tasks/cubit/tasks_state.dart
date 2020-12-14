part of 'tasks_cubit.dart';

abstract class TasksState extends Equatable {
  const TasksState();

  @override
  List<Object> get props => [];
}

class TasksInitial extends TasksState {}

class TasksLoadInProgress extends TasksState {}

class TasksLoadSuccess extends TasksState {
  final List<Task> tasks;

  TasksLoadSuccess(this.tasks);

  @override
  List<Object> get props => [tasks];
}

class TasksLoadFailure extends TasksState {
  final String message;

  TasksLoadFailure([this.message = 'Failed to load tasks']);

  @override
  List<Object> get props => [message];
}
