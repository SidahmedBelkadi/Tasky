import 'package:dartz/dartz.dart';
import 'package:tasky/src/core/error/failure.dart';
import 'package:tasky/src/features/profile/domain/entities/user_entity.dart';
import 'package:tasky/src/features/profile/domain/repositories/profile_repository.dart';

class ProfileUseCase {
  final ProfileRepository repository;

  ProfileUseCase({required this.repository});

  Future<Either<Failure, UserEntity>> call() async {
    return await repository.profile();
  }
}
