import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/utils/resources/app_messages.dart';
import '../../../data/data_sources/local/authentication_local_data_source.dart';
import '../../../data/data_sources/remote/authentication_remote_data_source.dart';
import '../../../domain/use_cases/sign_out.dart';

part 'sign_out_state.dart';

class SignOutCubit extends Cubit<SignOutState> {
  final AuthenticationLocalDataSource localDataSource;
  final AuthenticationRemoteDataSource remoteDataSource;
  final SignOutUseCase signOutUseCase;

  SignOutCubit({
    required this.signOutUseCase,
    required this.localDataSource,
    required this.remoteDataSource,
  }) : super(SignOutInitial());

  Future<void> signOut() async {
    emit(SignOutLoading());

    final authResponse = localDataSource.getSavedLoginCredentials();
    if (authResponse != null) {
      final result = await signOutUseCase(token: authResponse.accessToken);
      result.fold(
        (failure) {
          emit(SignOutUnSuccessful(message: failure.message));
        },
        (_) async {
          await localDataSource.clearLoginCredentials();
          emit(SignOutSuccessful());
        },
      );
    } else {
      emit(const SignOutUnSuccessful(message: AppMessages.unexpectedError));
    }
  }
}
