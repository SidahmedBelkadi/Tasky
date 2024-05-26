import 'package:dartz/dartz.dart';
import 'package:todo_app/src/core/error/failure.dart';
import 'package:todo_app/src/features/task/domain/entities/task_entity.dart';
import 'package:todo_app/src/features/task/domain/repositories/tasks_repository.dart';

class GetOneTaskUseCase {
  final TasksRepository repository;
  GetOneTaskUseCase({required this.repository});

  Future<Either<Failure, TaskEntity>> call({required String taskId}) async {
    return await repository.one(taskId: taskId);
  }
}
