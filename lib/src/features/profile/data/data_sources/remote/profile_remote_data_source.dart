import 'dart:convert';
import 'package:tasky/src/core/api/dio_consumer.dart';
import 'package:tasky/src/core/api/end_points.dart';
import 'package:tasky/src/features/profile/data/models/user_model.dart';

abstract class ProfileRemoteDataSource {
  Future<UserModel> profile();
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final DioConsumer dioConsumer;

  ProfileRemoteDataSourceImpl({required this.dioConsumer});

  @override
  Future<UserModel> profile() async {
    final response = await dioConsumer.get(EndPoints.profile);
    final UserModel profile = UserModel.fromJson(jsonDecode(response));
    // await Future.delayed(Duration(seconds: 3));
    return profile;
  }
}
