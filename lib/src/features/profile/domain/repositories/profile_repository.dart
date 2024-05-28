import 'package:dartz/dartz.dart';
import 'package:tasky/src/core/error/failure.dart';
import 'package:tasky/src/features/profile/domain/entities/user_entity.dart';

abstract class ProfileRepository {
  Future<Either<Failure, UserEntity>> profile();
}
