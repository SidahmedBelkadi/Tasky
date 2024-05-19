import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:todo_app/src/core/common/widgets/app_text_form_field.dart';
import 'package:todo_app/src/core/utils/app_strings.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Form(
      child: Column(
        children: [
          IntlPhoneField(initialCountryCode: 'DZ'),
          AppTextFormField(
            hint: AppStrings.password,
            suffixIcon: Icons.visibility_outlined,
          ),
        ],
      ),
    );
  }
}
