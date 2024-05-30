import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky/src/core/utils/helpers/dialog_helper.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/common/widgets/account_question.dart';
import '../../../../core/common/widgets/female_header_image.dart';
import '../../../../core/utils/helpers/media_query_values.dart';
import '../../../../core/utils/helpers/toast_helper.dart';
import '../../../../core/utils/resources/app_strings.dart';
import '../../domain/entities/sign_in_params.dart';
import 'cubit/sign_in_cubit.dart';
import 'widgets/button.dart';
import 'widgets/form.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldExit = await AppDialog.showExitConfirmationDialog(context);
        return shouldExit ?? false;
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: SizedBox(
              height: context.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // SignIn Header Image Background
                  const FemaleHeaderImageBackground(fit: BoxFit.fill),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // SignIn Title
                        Text(AppStrings.login, style: Theme.of(context).textTheme.headlineMedium),

                        SizedBox(height: 16.h),

                        // SignIn Form
                        const SignInForm(),

                        SizedBox(height: 24.0.h),

                        // SignIn Button
                        BlocConsumer<SignInCubit, SignInState>(
                          listener: (context, state) {
                            if (state is SignInSuccessful) {
                              Navigator.of(context).pushReplacementNamed(Routes.tasksHome);
                            } else if (state is SignInUnSuccessful) {
                              AppToasts.showErrorToast(message: state.message, context: context);
                            }
                          },
                          builder: (context, state) {
                            if (state is SignInLoading) {
                              return SignInButton(onPressed: () {}, isLoading: true);
                            }
                            return SignInButton(
                              onPressed: () {
                                final cubit = context.read<SignInCubit>();
                                _signIn(context, cubit);
                              },
                            );
                          },
                        ),

                        AccountQuestion(
                          text: AppStrings.dontHaveAccount,
                          buttonText: AppStrings.signUpHere,
                          onPressed: () {
                            Navigator.of(context).pushReplacementNamed(Routes.signUp);
                          },
                        ),

                        SizedBox(height: 48.h),
                      ],
                    ),
                  ),

                  // Account Question
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

_signIn(BuildContext context, SignInCubit cubit) {
  final phoneNumber = cubit.phoneController.value?.international.trim() ?? '';

  final signInParams = SignInParams(
    phoneNumber: phoneNumber,
    password: cubit.passwordController.text.trim(),
  );

  cubit.signIn(signInParams: signInParams);
}
