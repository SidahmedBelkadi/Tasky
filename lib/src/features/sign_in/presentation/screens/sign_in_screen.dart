import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/src/core/common/widgets/account_question.dart';
import 'package:todo_app/src/core/utils/app_strings.dart';
import 'package:todo_app/src/core/utils/media_query_values.dart';
import 'package:todo_app/src/core/common/widgets/female_header_image.dart';
import 'package:todo_app/src/features/sign_in/presentation/widgets/button.dart';
import 'package:todo_app/src/features/sign_in/presentation/widgets/form.dart';

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
              children: [
                /// SignIn Header Image Background
                const FemaleHeaderImageBackground(),

                SizedBox(height: 16.h),

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
                      const SignInButton(),
                    ],
                  ),
                ),
                SizedBox(height: 32.h),

                /// Account Question
                const AccountQuestion(
                  text: AppStrings.dontHaveAccount,
                  buttonText: AppStrings.signUpHere,
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
