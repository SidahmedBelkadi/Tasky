import 'dart:convert';

import '../../../../../core/api/dio_consumer.dart';
import '../../../../../core/api/end_points.dart';
import '../../../domain/entities/sign_in_params.dart';
import '../../../domain/entities/sign_up_params.dart';
import '../../models/auth_response_model.dart';

abstract class AuthenticationRemoteDataSource {
  Future<AuthResponseModel> signUp({required SignUpParams signUpParams});
  Future<AuthResponseModel> signIn({required SignInParams signInParams});
  Future<void> signOut({required String token});
}

class AuthenticationRemoteDataSourceImpl implements AuthenticationRemoteDataSource {
  final DioConsumer dioConsumer;

  AuthenticationRemoteDataSourceImpl({required this.dioConsumer});

  @override
  Future<AuthResponseModel> signUp({required SignUpParams signUpParams}) async {
    final response = await dioConsumer.post(
      EndPoints.signUp,
      body: signUpParams.toJson(),
      includeToken: false,
    );

    return AuthResponseModel.fromJson(jsonDecode(response));
  }

  @override
  Future<AuthResponseModel> signIn({required SignInParams signInParams}) async {
    final response = await dioConsumer.post(
      EndPoints.signIn,
      body: signInParams.toJson(),
      includeToken: false,
    );

    return AuthResponseModel.fromJson(jsonDecode(response));
  }

  @override
  Future<void> signOut({required String token}) async {
    await dioConsumer.post(
      EndPoints.signOut,
      body: {'token': token},
    );
  }
}
