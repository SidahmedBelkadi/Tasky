import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/password_field.dart';
import '../../widgets/phone_field.dart';
import '../cubit/sign_in_cubit.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({
    super.key,
  });

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  bool isObsecure = true;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignInCubit>();

    return Form(
      key: cubit.formKey,
      child: Column(
        children: [
          PhoneField(
            phoneController: cubit.phoneController,
          ),
          SizedBox(height: 12.h),
          PasswordField(
              isObsecure: isObsecure,
              controller: cubit.passwordController,
              toggleVisibility: () {
                setState(() {
                  isObsecure = !isObsecure;
                });
              }),
        ],
      ),
    );
  }
}
