import 'package:dartz/dartz.dart';
import 'package:todo_app/src/core/error/failure.dart';
import 'package:todo_app/src/core/utils/networking/network_info.dart';
import 'package:todo_app/src/core/utils/resources/app_messages.dart';
import 'package:todo_app/src/features/task/data/data_sources/remote/tasks_remote_data_source.dart';
import 'package:todo_app/src/features/task/data/models/task_model.dart';
import 'package:todo_app/src/features/task/domain/entities/task_entity.dart';
import 'package:todo_app/src/features/task/domain/repositories/tasks_repository.dart';

class TasksRepositioryImpl implements TasksRepository {
  final NetworkInfo networkInfo;
  final TasksRemoteDataSource remoteDataSource;

  TasksRepositioryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, TaskEntity>> create({required TaskEntity taskEntity}) async {
    final TaskModel taskModel = TaskModel.fromEntity(taskEntity);
    if (await networkInfo.isConnected) {
      try {
        final TaskEntity taskEntity = await remoteDataSource.create(taskModel: taskModel);
        return Right(taskEntity);
      } catch (e) {
        return Left(ServerFailure(message: e.toString()));
      }
    }
    return const Left(NoInternetConnectionFailure(message: AppMessages.noInternetConnection));
  }
}
