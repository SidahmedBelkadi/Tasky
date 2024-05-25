import 'package:dartz/dartz.dart';
import 'package:todo_app/src/core/error/failure.dart';
import 'package:todo_app/src/features/task/domain/entities/task_entity.dart';
import 'package:todo_app/src/features/task/domain/repositories/tasks_repository.dart';

class CreateTaskUseCase {
  final TasksRepository repository;
  CreateTaskUseCase({required this.repository});

  Future<Either<Failure, TaskEntity>> call({required TaskEntity taskEntity}) async {
    return await repository.create(taskEntity: taskEntity);
  }
}
