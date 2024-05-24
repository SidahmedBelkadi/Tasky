import 'package:dartz/dartz.dart';
import '../../domain/entities/sign_in_params.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/utils/handlers/error_handler.dart';
import '../../../../core/utils/networking/network_info.dart';
import '../../../../core/utils/resources/app_messages.dart';
import '../../domain/entities/auth_response_entity.dart';
import '../../domain/entities/sign_up_params.dart';
import '../../domain/repositories/auth_repository.dart';
import '../data_sources/remote/authentication_remote_data_source.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationRemoteDataSource authenticationRemoteDataSource;
  final NetworkInfo networkInfo;

  AuthenticationRepositoryImpl({
    required this.authenticationRemoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, AuthResponseEntity>> signUp({required SignUpParams signUpParams}) async {
    if (await networkInfo.isConnected) {
      try {
        final authResponseModel =
            await authenticationRemoteDataSource.signUp(signUpParams: signUpParams);
        return Right(authResponseModel);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: ErrorHandler.getErrorMessage(e)));
      }
    } else {
      return const Left(NoInternetConnectionFailure(message: AppMessages.noInternetConnection));
    }
  }

  @override
  Future<Either<Failure, AuthResponseEntity>> signIn({required SignInParams signInParams}) async {
    if (await networkInfo.isConnected) {
      try {
        final authResponseModel =
            await authenticationRemoteDataSource.signIn(signInParams: signInParams);
        return Right(authResponseModel);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: ErrorHandler.getErrorMessage(e)));
      }
    } else {
      return const Left(NoInternetConnectionFailure(message: AppMessages.noInternetConnection));
    }
  }

  @override
  Future<Either<Failure, void>> signOut({required String token}) async {
    if (await networkInfo.isConnected) {
      try {
        await authenticationRemoteDataSource.signOut(token: token);
        return const Right(null);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: ErrorHandler.getErrorMessage(e)));
      } catch (e) {
        return Left(ServerFailure(message: e.toString()));
      }
    } else {
      return const Left(NoInternetConnectionFailure(message: AppMessages.noInternetConnection));
    }
  }
}
