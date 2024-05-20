import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/common/widgets/account_question.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/media_query_values.dart';
import '../widgets/button.dart';
import '../widgets/form.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: context.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /// SignIn Header Image Background
                // const FemaleHeaderImageBackground(fit: BoxFit.fill),

                // SizedBox(height: 16.h),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// SignIn Title
                      Text(AppStrings.login, style: Theme.of(context).textTheme.headlineMedium),

                      SizedBox(height: 16.h),

                      /// SignIn Form
                      const SignInForm(),

                      SizedBox(height: 24.0.h),

                      /// SignIn Button
                      SignInButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed(Routes.tasksHome);
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 32.h),

                /// Account Question
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
        ),
      ),
    );
  }
}