import 'package:dartz/dartz.dart';
import '../entities/sign_in_params.dart';

import '../../../../core/error/failure.dart';
import '../entities/auth_response_entity.dart';
import '../repositories/auth_repository.dart';

class SignInUseCase {
  final AuthenticationRepository repository;

  SignInUseCase({required this.repository});

  Future<Either<Failure, AuthResponseEntity>> call({required SignInParams signInParams}) async {
    return await repository.signIn(signInParams: signInParams);
  }
}
