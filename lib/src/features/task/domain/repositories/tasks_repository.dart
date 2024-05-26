import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:todo_app/src/core/error/failure.dart';
import 'package:todo_app/src/features/task/domain/entities/task_entity.dart';

abstract class TasksRepository {
  Future<Either<Failure, TaskEntity>> create({
    required TaskEntity taskEntity,
    required File imageFile,
  });
  Future<Either<Failure, List<TaskEntity>>> read({required int page});
  Future<Either<Failure, TaskEntity>> one({required String taskId});
}
