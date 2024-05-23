import 'dart:convert';

import '../../../../../core/api/dio_consumer.dart';
import '../../../../../core/api/end_points.dart';
import '../../../domain/entities/sign_up_params.dart';
import '../../models/auth_response_model.dart';

abstract class AuthenticationRemoteDataSource {
  Future<AuthResponseModel> signUp({required SignUpParams signUpParams});
}

class AuthenticationRemoteDataSourceImpl implements AuthenticationRemoteDataSource {
  final DioConsumer dioConsumer;

  AuthenticationRemoteDataSourceImpl({required this.dioConsumer});

  @override
  Future<AuthResponseModel> signUp({required SignUpParams signUpParams}) async {
    final response = await dioConsumer.post(
      EndPoints.signUp,
      body: signUpParams.toJson(),
    );

    return AuthResponseModel.fromJson(jsonDecode(response));
  }
}
