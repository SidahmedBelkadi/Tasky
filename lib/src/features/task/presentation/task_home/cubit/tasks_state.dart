part of 'tasks_cubit.dart';

abstract class TasksState extends Equatable {
  final String selectedCategory;

  const TasksState({required this.selectedCategory});

  @override
  List<Object> get props => [selectedCategory];
}

class TasksInitial extends TasksState {
  const TasksInitial({required String selectedCategory})
      : super(selectedCategory: selectedCategory);
}

abstract class TasksWithData extends TasksState {
  final List<TaskEntity> tasks;

  const TasksWithData(this.tasks, {required String selectedCategory})
      : super(selectedCategory: selectedCategory);

  @override
  List<Object> get props => [tasks, selectedCategory];
}

class GetAllTasksSuccessfully extends TasksWithData {
  final bool hasMoreTasks;

  const GetAllTasksSuccessfully({
    required List<TaskEntity> tasks,
    required this.hasMoreTasks,
    required String selectedCategory,
  }) : super(tasks, selectedCategory: selectedCategory);

  @override
  List<Object> get props => [tasks, hasMoreTasks, selectedCategory];
}

class FetchingMoreTasks extends TasksWithData {
  const FetchingMoreTasks(List<TaskEntity> tasks, {required String selectedCategory})
      : super(tasks, selectedCategory: selectedCategory);

  @override
  List<Object> get props => [tasks, selectedCategory];
}

class GetAllTasksUnSuccessfully extends TasksState {
  final String message;

  const GetAllTasksUnSuccessfully({
    required this.message,
    required String selectedCategory,
  }) : super(selectedCategory: selectedCategory);

  @override
  List<Object> get props => [message, selectedCategory];
}

class GetAllTasksLoading extends TasksState {
  const GetAllTasksLoading({required String selectedCategory})
      : super(selectedCategory: selectedCategory);
}
