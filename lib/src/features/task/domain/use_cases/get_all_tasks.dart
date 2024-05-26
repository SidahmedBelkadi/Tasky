import 'package:dartz/dartz.dart';
import 'package:todo_app/src/core/error/failure.dart';
import 'package:todo_app/src/features/task/domain/entities/task_entity.dart';
import 'package:todo_app/src/features/task/domain/repositories/tasks_repository.dart';

class GetAllTastsUseCase {
  final TasksRepository repository;
  GetAllTastsUseCase({required this.repository});

  Future<Either<Failure, List<TaskEntity>>> call({required int page}) async {
    return await repository.read(page: page);
  }
}
