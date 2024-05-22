import 'package:equatable/equatable.dart';
import 'package:todo_app/src/core/utils/app_messages.dart';

class ServerException extends Equatable implements Exception {
  final String? message;

  const ServerException([this.message]);

  @override
  List<Object?> get props => [message];

  @override
  String toString() {
    return '$message';
  }
}

class FetchDataException extends ServerException {
  const FetchDataException([message]) : super(AppMessages.errorDuringCommunication);
}

class BadRequestException extends ServerException {
  const BadRequestException([message]) : super(AppMessages.badRequest);
}

class UnauthorizedException extends ServerException {
  const UnauthorizedException([message]) : super(AppMessages.unauthorized);
}

class NotFoundException extends ServerException {
  const NotFoundException([message]) : super(AppMessages.requestedInfoNotFound);
}

class ConflictException extends ServerException {
  const ConflictException([message]) : super(AppMessages.conflictOccurred);
}

class InternalServerErrorException extends ServerException {
  const InternalServerErrorException([message]) : super(AppMessages.internalServerError);
}

class NoInternetConnectionException extends ServerException {
  const NoInternetConnectionException([message]) : super(AppMessages.noInternetConnection);
}

class CacheException implements Exception {}
