import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/auth_response_entity.dart';
import '../entities/sign_up_params.dart';
import '../repositories/auth_repository.dart';

class SignUpUseCase {
  final AuthenticationRepository repository;

  SignUpUseCase({required this.repository});

  Future<Either<Failure, AuthResponseEntity>> call({required SignUpParams signUpParams}) async {
    return await repository.signUp(signUpParams: signUpParams);
  }
}
