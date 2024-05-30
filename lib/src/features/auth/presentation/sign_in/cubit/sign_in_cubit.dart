import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:phone_input/phone_input_package.dart';

import '../../../data/data_sources/local/authentication_local_data_source.dart';
import '../../../data/models/auth_response_model.dart';
import '../../../domain/entities/auth_response_entity.dart';
import '../../../domain/entities/sign_in_params.dart';
import '../../../domain/use_cases/sign_in_usecase.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final SignInUseCase signInUseCase;
  final AuthenticationLocalDataSource localDataSource;

  SignInCubit({
    required this.signInUseCase,
    required this.localDataSource,
  }) : super(SignInInitial());

  /// Variables
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final phoneController = PhoneController(
    const PhoneNumber(isoCode: IsoCode.DZ, nsn: ''),
  );
  final passwordController = TextEditingController();

  /// SignIn
  Future<void> signIn({required SignInParams signInParams}) async {
    final isValidated = formKey.currentState!.validate();
    if (!isValidated) {
      return;
    }

    emit(SignInLoading());

    final failureOrAuthResponseEntity = await signInUseCase(
      signInParams: SignInParams(
        phoneNumber: signInParams.phoneNumber,
        password: signInParams.password,
      ),
    );

    failureOrAuthResponseEntity.fold(
      (error) {
        emit(SignInUnSuccessful(message: error.message));
      },
      (authResponseEntity) async {
        await localDataSource.saveLoginCredentials(
          authResponse: AuthResponseModel(
            userId: authResponseEntity.userId,
            name: authResponseEntity.name,
            accessToken: authResponseEntity.accessToken,
            refreshToken: authResponseEntity.refreshToken,
          ),
        );
        emit(SignInSuccessful(authResponseEntity: authResponseEntity));
      },
    );
  }
}
