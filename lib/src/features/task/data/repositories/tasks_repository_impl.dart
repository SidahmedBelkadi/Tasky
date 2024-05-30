import 'dart:io';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/utils/networking/network_info.dart';
import '../../../../core/utils/resources/app_messages.dart';
import '../data_sources/remote/tasks_remote_data_source.dart';
import '../models/task_model.dart';
import '../../domain/entities/task_entity.dart';
import '../../domain/repositories/tasks_repository.dart';

class TasksRepositioryImpl implements TasksRepository {
  final NetworkInfo networkInfo;
  final TasksRemoteDataSource remoteDataSource;

  TasksRepositioryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, TaskEntity>> create({
    required TaskEntity taskEntity,
    required File imageFile,
  }) async {
    final TaskModel taskModel = TaskModel.fromEntity(taskEntity);
    if (await networkInfo.isConnected) {
      try {
        final TaskEntity taskEntity =
            await remoteDataSource.create(taskModel: taskModel, imageFile: imageFile);
        return Right(taskEntity);
      } catch (e) {
        return Left(ServerFailure(message: e.toString()));
      }
    }
    return const Left(NoInternetConnectionFailure(message: AppMessages.noInternetConnection));
  }

  @override
  Future<Either<Failure, List<TaskEntity>>> read({required int page}) async {
    if (await networkInfo.isConnected) {
      try {
        final List<TaskEntity> tasks = await remoteDataSource.read(page: page);
        return Right(tasks);
      } catch (e) {
        return Left(ServerFailure(message: e.toString()));
      }
    }
    return const Left(NoInternetConnectionFailure(message: AppMessages.noInternetConnection));
  }

  @override
  Future<Either<Failure, TaskEntity>> one({required String taskId}) async {
    if (await networkInfo.isConnected) {
      try {
        final TaskEntity task = await remoteDataSource.one(taskId: taskId);
        return Right(task);
      } catch (e) {
        return Left(ServerFailure(message: e.toString()));
      }
    }
    return const Left(NoInternetConnectionFailure(message: AppMessages.noInternetConnection));
  }

  @override
  Future<Either<Failure, Unit>> delete({required String taskId}) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.delete(taskId: taskId);
        return const Right(unit);
      } catch (e) {
        return Left(ServerFailure(message: e.toString()));
      }
    }
    return const Left(NoInternetConnectionFailure(message: AppMessages.noInternetConnection));
  }

  @override
  Future<Either<Failure, TaskEntity>> update({required TaskEntity taskEntity}) async {
    if (await networkInfo.isConnected) {
      final TaskModel taskModel = TaskModel.fromEntity(taskEntity);
      try {
        final TaskEntity taskEntity = await remoteDataSource.update(taskModel: taskModel);
        return Right(taskEntity);
      } catch (e) {
        return Left(ServerFailure(message: e.toString()));
      }
    }
    return const Left(NoInternetConnectionFailure(message: AppMessages.noInternetConnection));
  }
}
