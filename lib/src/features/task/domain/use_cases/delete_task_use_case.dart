import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../repositories/tasks_repository.dart';

class DeleteTaskUseCase {
  final TasksRepository repository;
  DeleteTaskUseCase({required this.repository});

  Future<Either<Failure, Unit>> call({required String taskId}) async {
    return await repository.delete(taskId: taskId);
  }
}
