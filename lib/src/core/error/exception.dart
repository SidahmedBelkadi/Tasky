import 'package:equatable/equatable.dart';

class ServerException extends Equatable implements Exception {
  final String? message;

  const ServerException([this.message]);

  @override
  List<Object?> get props => [message ?? ''];

  @override
  String toString() {
    return message ?? 'ServerException';
  }
}

class FetchDataException extends ServerException {
  const FetchDataException([String? message]) : super(message);
}

class BadRequestException extends ServerException {
  const BadRequestException([String? message]) : super(message);
}

class UnauthorizedException extends ServerException {
  const UnauthorizedException([String? message]) : super(message);
}

class NotFoundException extends ServerException {
  const NotFoundException([String? message]) : super(message);
}

class ConflictException extends ServerException {
  const ConflictException([String? message]) : super(message);
}

class InternalServerErrorException extends ServerException {
  const InternalServerErrorException([String? message]) : super(message);
}

class NoInternetConnectionException extends ServerException {
  const NoInternetConnectionException([String? message]) : super(message);
}

class CancelRequestException extends ServerException {
  const CancelRequestException([String? message]) : super(message);
}

class UnprocessableEntityException extends ServerException {
  const UnprocessableEntityException([String? message]) : super(message);
}
