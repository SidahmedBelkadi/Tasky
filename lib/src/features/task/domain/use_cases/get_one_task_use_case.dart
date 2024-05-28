import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/task_entity.dart';
import '../repositories/tasks_repository.dart';

class GetOneTaskUseCase {
  final TasksRepository repository;
  GetOneTaskUseCase({required this.repository});

  Future<Either<Failure, TaskEntity>> call({required String taskId}) async {
    return await repository.one(taskId: taskId);
  }
}
