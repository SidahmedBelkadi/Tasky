import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/common/widgets/account_question.dart';
import '../../../../core/utils/helpers/toast_helper.dart';
import '../../../../core/utils/resources/app_messages.dart';
import '../../../../core/utils/resources/app_strings.dart';
import '../../domain/entities/sign_up_params.dart';
import 'cubit/sign_up_cubit.dart';
import 'widgets/button.dart';
import 'widgets/form.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            // height: context.height,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16.h),

                  /// SignUp Title
                  Text(AppStrings.signUp, style: Theme.of(context).textTheme.headlineMedium),

                  SizedBox(height: 16.h),

                  /// SignUp Form
                  const SignUpForm(),

                  SizedBox(height: 24.h),

                  /// SignUp Button
                  BlocConsumer<SignUpCubit, SignUpState>(
                    listener: (context, state) {
                      if (state is SignUpSuccessful) {
                        AppToasts.showSuccessToast(
                            message: AppMessages.accountCreated, context: context);
                        Navigator.of(context).pushReplacementNamed(Routes.tasksHome);
                      } else if (state is SignUpUnSuccessful) {
                        AppToasts.showErrorToast(message: state.message, context: context);
                      }
                    },
                    builder: (context, state) {
                      if (state is SignUpLoading) {
                        return SignUpButton(onPressed: () {}, isLoading: true);
                      }
                      return SignUpButton(
                        onPressed: () {
                          final cubit = context.read<SignUpCubit>();
                          _signUp(context, cubit);
                        },
                      );
                    },
                  ),

                  SizedBox(height: 24.h),

                  /// Account Question
                  AccountQuestion(
                    text: AppStrings.alreadyHaveAcc,
                    buttonText: AppStrings.signIn,
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed(Routes.signIn);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

_signUp(BuildContext context, SignUpCubit cubit) {
  final phoneNumber = cubit.phoneController.value?.international.trim() ?? '';

  final signUpParams = SignUpParams(
    name: cubit.nameController.text.trim(),
    phoneNumber: phoneNumber,
    experienceLevel: cubit.experienceLevel.trim(),
    yearsOfExperience: cubit.experienceYearsController.text.trim(),
    address: cubit.addressController.text.trim(),
    password: cubit.passwordController.text.trim(),
  );
  cubit.signUp(signUpParams: signUpParams);
}
