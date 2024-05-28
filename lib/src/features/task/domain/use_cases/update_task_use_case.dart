import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/task_entity.dart';
import '../repositories/tasks_repository.dart';

class UpdateTaskUseCase {
  final TasksRepository repository;
  UpdateTaskUseCase({required this.repository});

  Future<Either<Failure, TaskEntity>> call({required TaskEntity taskEntity}) async {
    return await repository.update(taskEntity: taskEntity);
  }
}
