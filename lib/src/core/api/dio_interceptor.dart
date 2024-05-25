import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../features/auth/data/data_sources/local/authentication_local_data_source.dart';
import '../../features/auth/data/models/auth_response_model.dart';
import 'end_points.dart';
import 'status_code.dart';

class DioInterceptor extends Interceptor {
  static const String skipAuthHeader = 'skip-auth';
  final Dio client;
  final AuthenticationLocalDataSource authLocalDataSource;

  DioInterceptor({
    required this.authLocalDataSource,
    required this.client,
  });

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers[HttpHeaders.acceptHeader] = ContentType.json.toString();

    // Check if the request should skip authorization
    if (options.headers.containsKey(skipAuthHeader) || options.path == EndPoints.refreshToken) {
      options.headers.remove(skipAuthHeader); // Remove the custom header
    } else {
      final authResponse = authLocalDataSource.getSavedLoginCredentials();
      if (authResponse != null) {
        options.headers[HttpHeaders.authorizationHeader] = 'Bearer ${authResponse.accessToken}';
      }
    }

    debugPrint('REQUEST[${options.method}] => PATH: ${options.path}');
    debugPrint('HEADERS: ${options.headers}');
    debugPrint('BODY: ${options.data}');

    handler.next(options); // Continue with the request
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint('RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    handler.next(response); // Continue with the response
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    debugPrint('ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    if (err.response?.statusCode == StatusCode.unauthorized) {
      final authResponse = authLocalDataSource.getSavedLoginCredentials();
      if (authResponse != null) {
        if (await _refreshToken(authResponse)) {
          handler.resolve(await _retry(err.requestOptions));
          return;
        }
      }
    }
    handler.next(err); // Continue with the error
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return client.request<dynamic>(requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options);
  }

  Future<bool> _refreshToken(AuthResponseModel authResponse) async {
    final response = await client.get(
      EndPoints.refreshToken,
      queryParameters: {
        'token': authResponse.refreshToken,
      },
    );

    if (response.statusCode == StatusCode.ok) {
      final jsonResponse = json.decode(response.data);
      final newAccessToken = jsonResponse["access_token"];

      // Update the AuthResponseModel with the new access token
      final updatedAuthResponse = AuthResponseModel(
        userId: authResponse.userId,
        name: authResponse.name,
        accessToken: newAccessToken,
        refreshToken: authResponse.refreshToken, // Keep the existing refresh token
      );

      // Save the new access token in local storage
      await authLocalDataSource.saveLoginCredentials(authResponse: updatedAuthResponse);
      return true;
    } else {
      return false;
    }
  }
}
