import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/src/features/task/domain/entities/task_entity.dart';
import 'package:todo_app/src/features/task/domain/use_cases/get_one_task_use_case.dart';

part 'task_detail_state.dart';

class TaskDetailCubit extends Cubit<TaskDetailState> {
  final GetOneTaskUseCase useCase;
  TaskDetailCubit({required this.useCase}) : super(TaskDetailInitial());

  Future<void> getTaskDetails({required String taskId}) async {
    emit(GetTaskDetailLoading());

    final failureOrTask = await useCase(taskId: taskId);

    failureOrTask.fold(
      (failure) => emit(GetTaskDetailUnSuccessful(message: failure.message)),
      (task) => emit(
        GetTaskDetailSuccessful(taskEntity: task),
      ),
    );
  }
}
