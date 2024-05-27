import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/task_entity.dart';
import '../../../domain/use_cases/create_task_use_case.dart';

part 'add_task_state.dart';

class AddTaskCubit extends Cubit<AddTaskState> {
  CreateTaskUseCase useCase;
  AddTaskCubit({required this.useCase}) : super(AddTaskInitial());

  Future<void> create({required TaskEntity taskEntity, required File imageFile}) async {
    emit(AddTaskLoading());

    final failureOrTask = await useCase(taskEntity: taskEntity, imageFile: imageFile);

    failureOrTask.fold(
      (failure) => emit(AddTaskUnSuccessful(message: failure.message)),
      (task) => emit(
        AddTaskSuccessful(taskEntity: taskEntity),
      ),
    );
  }
}
