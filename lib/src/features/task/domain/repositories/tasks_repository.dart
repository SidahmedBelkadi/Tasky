import 'dart:io';

import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/task_entity.dart';

abstract class TasksRepository {
  Future<Either<Failure, TaskEntity>> create({
    required TaskEntity taskEntity,
    required File imageFile,
  });
  Future<Either<Failure, List<TaskEntity>>> read({required int page});
  Future<Either<Failure, TaskEntity>> one({required String taskId});
  Future<Either<Failure, Unit>> delete({required String taskId});
}
