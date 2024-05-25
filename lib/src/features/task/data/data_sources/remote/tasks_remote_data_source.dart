import 'dart:convert';

import 'package:todo_app/src/core/api/dio_consumer.dart';
import 'package:todo_app/src/core/api/end_points.dart';
import 'package:todo_app/src/features/task/data/models/task_model.dart';

abstract class TasksRemoteDataSource {
  Future<TaskModel> create({required TaskModel taskModel});
}

class TasksRemoteDataSourceImpl implements TasksRemoteDataSource {
  final DioConsumer dioConsumer;

  TasksRemoteDataSourceImpl({
    required this.dioConsumer,
  });

  @override
  Future<TaskModel> create({required TaskModel taskModel}) async {
    final response = await dioConsumer.post(
      EndPoints.createTask,
      body: taskModel.toJson(),
    );
    return TaskModel.fromJson(jsonDecode(response));
  }
}
