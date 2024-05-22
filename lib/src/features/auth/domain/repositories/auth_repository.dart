import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/sign_up_params.dart';
import '../entities/user_entity.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, UserEntity>> signUp({required SignUpParams signUpParams});
}
