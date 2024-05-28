import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import '../../../../../core/api/dio_consumer.dart';
import '../../../../../core/api/end_points.dart';
import '../../models/task_model.dart';

abstract class TasksRemoteDataSource {
  Future<TaskModel> create({required TaskModel taskModel, required File imageFile});
  Future<List<TaskModel>> read({required int page});
  Future<TaskModel> update({required TaskModel taskModel});
  Future<TaskModel> one({required String taskId});
  Future<void> delete({required String taskId});
}

class TasksRemoteDataSourceImpl implements TasksRemoteDataSource {
  final DioConsumer dioConsumer;

  TasksRemoteDataSourceImpl({
    required this.dioConsumer,
  });

  @override
  Future<TaskModel> create({required TaskModel taskModel, required File imageFile}) async {
    final formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(imageFile.path,
          filename: taskModel.image, contentType: MediaType('image', 'jpeg')),
    });
    final uploadRespone = await dioConsumer.post(
      EndPoints.taskImageUpload,
      body: formData,
      formDataIsEnabled: true,
    );
    final imageFileName = jsonDecode(uploadRespone)['image'];
    final response = await dioConsumer.post(
      EndPoints.task,
      body: taskModel.copyWith(image: imageFileName).toJson(),
    );
    final createdTask = TaskModel.fromJson(jsonDecode(response));
    return createdTask;
  }

  @override
  Future<List<TaskModel>> read({required int page}) async {
    final response = await dioConsumer.get("${EndPoints.task}?page=$page");
    final List<dynamic> decodedResponse = jsonDecode(response);

    final List<TaskModel> tasks = decodedResponse.map((e) => TaskModel.fromJson(e)).toList();
    await Future.delayed(const Duration(seconds: 3));
    return tasks;
  }

  @override
  Future<TaskModel> one({required String taskId}) async {
    final response = await dioConsumer.get("${EndPoints.task}/$taskId");
    final decodedResponse = jsonDecode(response);
    return TaskModel.fromJson(decodedResponse);
  }

  @override
  Future<void> delete({required String taskId}) async {
    await dioConsumer.delete("${EndPoints.task}/$taskId");
  }

  @override
  Future<TaskModel> update({required TaskModel taskModel}) async {
    final response =
        await dioConsumer.put("${EndPoints.task}/${taskModel.id}", body: taskModel.toJson());
    final updatedTask = TaskModel.fromJson(jsonDecode(response));
    return updatedTask;
  }
}
