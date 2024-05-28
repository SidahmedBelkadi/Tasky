import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/task_entity.dart';
import '../repositories/tasks_repository.dart';

class GetAllTastsUseCase {
  final TasksRepository repository;
  GetAllTastsUseCase({required this.repository});

  Future<Either<Failure, List<TaskEntity>>> call({required int page}) async {
    return await repository.read(page: page);
  }
}
