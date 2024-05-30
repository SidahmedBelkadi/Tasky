import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:phone_input/phone_input_package.dart';

import '../../../data/data_sources/local/authentication_local_data_source.dart';
import '../../../data/models/auth_response_model.dart';
import '../../../domain/entities/auth_response_entity.dart';
import '../../../domain/entities/sign_up_params.dart';
import '../../../domain/use_cases/sign_up_usecase.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final SignUpUseCase signUpUseCase;
  final AuthenticationLocalDataSource localDataSource;

  SignUpCubit({
    required this.signUpUseCase,
    required this.localDataSource,
  }) : super(SignUpInitial());

  /// Variables
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = PhoneController(
    const PhoneNumber(isoCode: IsoCode.DZ, nsn: ''),
  );
  final experienceYearsController = TextEditingController();
  final addressController = TextEditingController();
  final passwordController = TextEditingController();
  String experienceLevel = '';

  /// SignUp
  Future<void> signUp({required SignUpParams signUpParams}) async {
    final isValidated = formKey.currentState!.validate();
    if (!isValidated) {
      return;
    }

    emit(SignUpLoading());

    final failureOrAuthResponseEntity = await signUpUseCase(signUpParams: signUpParams);

    failureOrAuthResponseEntity.fold(
      (error) {
        emit(SignUpUnSuccessful(message: error.message));
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
        emit(SignUpSuccessful(authResponseEntity: authResponseEntity));
      },
    );
  }
}
