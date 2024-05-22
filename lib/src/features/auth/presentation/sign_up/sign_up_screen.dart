import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/common/widgets/account_question.dart';
import '../../../../core/utils/app_strings.dart';
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
          child: Column(
            children: [
              SizedBox(height: 16.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// SignUp Title
                    Text(AppStrings.signUp, style: Theme.of(context).textTheme.headlineMedium),

                    SizedBox(height: 16.h),

                    /// SignUp Form
                    const SignUpForm(),

                    SizedBox(height: 24.h),

                    /// SignUp Button
                    SignUpButton(onPressed: () {
                      Navigator.of(context).pushReplacementNamed(Routes.tasksHome);
                    }),

                    /// SignUp Button
                    AccountQuestion(
                      text: AppStrings.alreadyHaveAcc,
                      buttonText: AppStrings.signIn,
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed(Routes.signIn);
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
