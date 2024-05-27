import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/task_entity.dart';
import '../../../domain/use_cases/delete_task_use_case.dart';
import '../../../domain/use_cases/get_one_task_use_case.dart';

part 'task_detail_state.dart';

class TaskDetailCubit extends Cubit<TaskDetailState> {
  final GetOneTaskUseCase getTaskDetailUseCase;
  final DeleteTaskUseCase deleteUseCase;
  TaskDetailCubit({required this.getTaskDetailUseCase, required this.deleteUseCase})
      : super(TaskDetailInitial());

  Future<void> getTaskDetails({required String taskId}) async {
    emit(GetTaskDetailLoading());

    final failureOrTask = await getTaskDetailUseCase(taskId: taskId);

    failureOrTask.fold(
      (failure) => emit(GetTaskDetailUnSuccessful(message: failure.message)),
      (task) => emit(
        GetTaskDetailSuccessful(taskEntity: task),
      ),
    );
  }

  Future<void> deleteTask({required String taskId}) async {
    emit(DeleteTaskLoading());

    final failureOrUnit = await deleteUseCase(taskId: taskId);

    failureOrUnit.fold(
      (failure) => emit(DeleteTaskUnSuccessful(message: failure.message)),
      (_) => emit(DeleteTaskSuccessful()),
    );
  }
}
