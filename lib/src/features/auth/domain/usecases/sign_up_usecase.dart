import 'package:dartz/dartz.dart';
import 'package:todo_app/src/core/error/failure.dart';
import 'package:todo_app/src/features/auth/domain/entities/sign_up_params.dart';
import 'package:todo_app/src/features/auth/domain/entities/user_entity.dart';
import 'package:todo_app/src/features/auth/domain/repositories/auth_repository.dart';

class SignUpUseCase {
  final AuthenticationRepository repository;

  SignUpUseCase({required this.repository});

  Future<Either<Failure, UserEntity>> call({required SignUpParams signUpParams}) async {
    return await repository.signUp(signUpParams: signUpParams);
  }
}
