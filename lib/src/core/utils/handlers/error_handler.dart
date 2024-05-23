import '../../error/exception.dart';
import '../resources/app_messages.dart';

class ErrorHandler {
  static String getErrorMessage(ServerException exception) {
    if (exception is FetchDataException) {
      return exception.message ?? AppMessages.errorDuringCommunication;
    } else if (exception is BadRequestException) {
      return exception.message ?? AppMessages.badRequest;
    } else if (exception is UnauthorizedException) {
      return exception.message ?? AppMessages.unauthorized;
    } else if (exception is NotFoundException) {
      return exception.message ?? AppMessages.requestedInfoNotFound;
    } else if (exception is ConflictException) {
      return exception.message ?? AppMessages.conflictOccurred;
    } else if (exception is InternalServerErrorException) {
      return exception.message ?? AppMessages.internalServerError;
    } else if (exception is NoInternetConnectionException) {
      return exception.message ?? AppMessages.noInternetConnection;
    } else if (exception is CancelRequestException) {
      return exception.message ?? AppMessages.noInternetConnection;
    } else if (exception is UnprocessableEntityException) {
      return exception.message ?? AppMessages.unprocessable;
    } else {
      return AppMessages.unexpectedError;
    }
  }
}
