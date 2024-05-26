part of 'task_detail_cubit.dart';

sealed class TaskDetailState extends Equatable {
  const TaskDetailState();

  @override
  List<Object> get props => [];
}

final class TaskDetailInitial extends TaskDetailState {}

final class GetTaskDetailSuccessful extends TaskDetailState {
  final TaskEntity taskEntity;

  const GetTaskDetailSuccessful({required this.taskEntity});

  @override
  List<Object> get props => [taskEntity];
}

final class GetTaskDetailUnSuccessful extends TaskDetailState {
  final String message;

  const GetTaskDetailUnSuccessful({required this.message});

  @override
  List<Object> get props => [message];
}

final class GetTaskDetailLoading extends TaskDetailState {}
