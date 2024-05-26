import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';

import '../../injection_container.dart' as di;
import '../error/exception.dart';
import '../utils/resources/app_messages.dart';
import 'api_consumer.dart';
import 'dio_interceptor.dart';
import 'end_points.dart';
import 'status_code.dart';

class DioConsumer extends ApiConsumer {
  final Dio client;

  DioConsumer({required this.client}) {
    _initializeClient();
  }

  void _initializeClient() {
    final httpClientAdapter = IOHttpClientAdapter();
    httpClientAdapter.createHttpClient = () {
      final client = HttpClient();
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      return client;
    };

    client.httpClientAdapter = httpClientAdapter;
    client.options
      ..baseUrl = EndPoints.baseUrl
      ..responseType = ResponseType.plain
      ..followRedirects = false;

    client.interceptors.add(di.serviceLocator<DioInterceptor>());
    if (kDebugMode) {
      client.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    }
  }

  @override
  Future<dynamic> get(String path,
      {Map<String, dynamic>? queryParameters, Map<String, String>? headers}) async {
    try {
      final response = await client.get(
        path,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
        ),
      );
      return response.data;
    } on DioException catch (error) {
      _handleDioError(error);
    }
  }

  @override
  // Future<dynamic> post(String path,
  //     {Map<String, dynamic>? body,
  //     bool formDataIsEnabled = false,
  //     Map<String, String>? headers,
  //     Map<String, dynamic>? queryParameters}) async {
  //   try {
  //     debugPrint("POST Request:");
  //     debugPrint("URL: ${client.options.baseUrl}$path");
  //     debugPrint("Headers: ${headers ?? client.options.headers}");
  //     debugPrint("Body: $body");

  //     final response = await client.post(
  //       path,
  //       data: formDataIsEnabled ? FormData.fromMap(body!) : body,
  //       options: Options(
  //         headers: headers,
  //       ),
  //       queryParameters: queryParameters,
  //     );
  //     return response.data;
  //   } on DioException catch (error) {
  //     _handleDioError(error);
  //   }
  // }

  // Future<dynamic> post(
  //   String path, {
  //   dynamic body,
  //   bool formDataIsEnabled = false,
  //   Map<String, String>? headers,
  //   Map<String, dynamic>? queryParameters,
  //   Options? options,
  //   bool includeToken = true,
  // }) async {
  //   try {
  //     final Map<String, String> finalHeaders = headers ?? {};
  //     if (!includeToken) {
  //       finalHeaders[DioInterceptor.skipAuthHeader] = 'true';
  //     }

  //     final response = await client.post(
  //       path,
  //       data: formDataIsEnabled ? FormData.fromMap(body!) : body,
  //       options: Options(
  //         headers: finalHeaders,
  //       ),
  //       queryParameters: queryParameters,
  //     );
  //     return response.data;
  //   } on DioException catch (error) {
  //     _handleDioError(error);
  //   }
  // }

  @override
  Future<dynamic> post(
    String path, {
    dynamic body,
    bool formDataIsEnabled = false,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
    Options? options,
    bool includeToken = true,
  }) async {
    try {
      final Map<String, String> finalHeaders = headers ?? {};
      if (!includeToken) {
        finalHeaders[DioInterceptor.skipAuthHeader] = 'true';
      }

      // If formData is enabled, add specific headers for multipart/form-data
      if (formDataIsEnabled) {
        finalHeaders[HttpHeaders.contentTypeHeader] = 'multipart/form-data';
      }

      final Options finalOptions = Options(
        headers: {...finalHeaders, ...?options?.headers},
        method: options?.method,
        responseType: options?.responseType,
        contentType: options?.contentType,
        extra: options?.extra,
        followRedirects: options?.followRedirects,
        receiveDataWhenStatusError: options?.receiveDataWhenStatusError,
        validateStatus: options?.validateStatus,
        receiveTimeout: options?.receiveTimeout,
        sendTimeout: options?.sendTimeout,
        requestEncoder: options?.requestEncoder,
        responseDecoder: options?.responseDecoder,
        listFormat: options?.listFormat,
      );

      final response = await client.post(
        path,
        data: formDataIsEnabled ? body : jsonEncode(body),
        options: finalOptions,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (error) {
      _handleDioError(error);
    }
  }

  @override
  Future<dynamic> delete(String path,
      {Map<String, dynamic>? body,
      Map<String, String>? headers,
      Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await client.delete(
        path,
        data: body,
        options: Options(
          headers: headers,
        ),
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (error) {
      _handleDioError(error);
    }
  }

  @override
  Future<dynamic> put(String path,
      {Map<String, dynamic>? body,
      Map<String, String>? headers,
      bool responseIsParsing = true,
      Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await client.put(
        path,
        data: body,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
        ),
      );
      return response.data;
    } on DioException catch (error) {
      _handleDioError(error);
    }
  }

  dynamic _handleDioError(DioException error) {
    String errorMessage = 'Unknown error';

    if (error.response?.data != null) {
      try {
        // Try to parse the response data as JSON
        final responseData = jsonDecode(error.response!.data);
        if (responseData is Map<String, dynamic> && responseData.containsKey('message')) {
          errorMessage = responseData['message'];
        } else {
          errorMessage = error.response!.data.toString();
        }
      } catch (e) {
        // If parsing fails, use the raw response data as the error message
        errorMessage = error.response!.data.toString();
      }
    }

    debugPrint("================ Error: $errorMessage ================");
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw const FetchDataException(AppMessages.errorDuringCommunication);
      case DioExceptionType.badResponse:
        switch (error.response?.statusCode) {
          case StatusCode.notFound:
            throw const NotFoundException(AppMessages.requestedInfoNotFound);
          case StatusCode.conflict:
            throw const ConflictException(AppMessages.conflictOccurred);
          case StatusCode.internalServerError:
            throw const InternalServerErrorException(AppMessages.internalServerError);
          case StatusCode.unauthorized:
            throw UnauthorizedException(errorMessage);
          case StatusCode.unprocessable:
            throw UnprocessableEntityException(errorMessage); // Show Real server message
          default:
            throw const ServerException(AppMessages.serverFailure);
        }
      case DioExceptionType.cancel:
        throw const CancelRequestException(AppMessages.noInternetConnection);
      case DioExceptionType.unknown:
        throw const NoInternetConnectionException(AppMessages.noInternetConnection);
      default:
        throw const ServerException(AppMessages.unexpectedError);
    }
  }
}
