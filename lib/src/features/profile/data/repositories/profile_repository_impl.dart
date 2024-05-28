import 'package:dartz/dartz.dart';
import 'package:tasky/src/core/error/failure.dart';
import 'package:tasky/src/core/utils/networking/network_info.dart';
import 'package:tasky/src/core/utils/resources/app_messages.dart';
import 'package:tasky/src/features/profile/data/data_sources/remote/profile_remote_data_source.dart';
import 'package:tasky/src/features/profile/domain/entities/user_entity.dart';
import 'package:tasky/src/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final NetworkInfo networkInfo;
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryImpl({required this.networkInfo, required this.remoteDataSource});

  @override
  Future<Either<Failure, UserEntity>> profile() async {
    if (await networkInfo.isConnected) {
      try {
        final UserEntity profile = await remoteDataSource.profile();
        return Right(profile);
      } catch (e) {
        return Left(ServerFailure(message: e.toString()));
      }
    }
    return const Left(NoInternetConnectionFailure(message: AppMessages.noInternetConnection));
  }
}
