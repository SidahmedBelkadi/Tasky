import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/auth_response_entity.dart';
import '../entities/sign_up_params.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, AuthResponseEntity>> signUp({required SignUpParams signUpParams});
}
