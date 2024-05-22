import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../../../core/common/widgets/app_text_form_field.dart';
import '../../../../../core/utils/app_strings.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          const AppTextFormField(hint: AppStrings.name),
          SizedBox(height: 24.h),
          const IntlPhoneField(initialCountryCode: 'DZ'),
          SizedBox(height: 24.h),
          DropdownButtonFormField(
            hint: const Text(
              AppStrings.chooseExpLevel,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            items: const [
              DropdownMenuItem(
                value: AppStrings.junior,
                child: Text(AppStrings.junior),
              ),
              DropdownMenuItem(
                value: AppStrings.midLevel,
                child: Text(AppStrings.midLevel),
              ),
              DropdownMenuItem(
                value: AppStrings.senior,
                child: Text(AppStrings.senior),
              ),
            ],
            onChanged: (value) {},
          ),
          SizedBox(height: 24.h),
          const AppTextFormField(hint: AppStrings.yearsOfExp),
          SizedBox(height: 24.h),
          const AppTextFormField(hint: AppStrings.address),
          SizedBox(height: 24.h),
          const AppTextFormField(
            hint: AppStrings.password,
            suffixIcon: Icons.visibility_outlined,
          ),
        ],
      ),
    );
  }
}
