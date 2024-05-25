part of 'add_task_cubit.dart';

sealed class AddTaskState extends Equatable {
  const AddTaskState();

  @override
  List<Object> get props => [];
}

final class AddTaskInitial extends AddTaskState {}

final class AddTaskSuccessful extends AddTaskState {
  final TaskEntity taskEntity;

  const AddTaskSuccessful({required this.taskEntity});

  @override
  List<Object> get props => [taskEntity];
}

final class AddTaskUnSuccessful extends AddTaskState {
  final String message;

  const AddTaskUnSuccessful({required this.message});

  @override
  List<Object> get props => [message];
}

final class AddTaskLoading extends AddTaskState {}
