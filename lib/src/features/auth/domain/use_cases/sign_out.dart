import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../repositories/auth_repository.dart';

class SignOutUseCase {
  final AuthenticationRepository repository;

  SignOutUseCase({required this.repository});

  Future<Either<Failure, void>> call({required String token}) async {
    return await repository.signOut(token: token);
  }
}
