import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/task_entity.dart';
import '../repositories/tasks_repository.dart';

class CreateTaskUseCase {
  final TasksRepository repository;
  CreateTaskUseCase({required this.repository});

  Future<Either<Failure, TaskEntity>> call(
      {required TaskEntity taskEntity, required File imageFile}) async {
    return await repository.create(taskEntity: taskEntity, imageFile: imageFile);
  }
}
