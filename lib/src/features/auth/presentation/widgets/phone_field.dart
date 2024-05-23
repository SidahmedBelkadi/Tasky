import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phone_input/phone_input_package.dart';

import '../../../../core/utils/resources/app_colors.dart';

class PhoneField extends StatelessWidget {
  const PhoneField({
    super.key,
    required this.phoneController,
    this.onChanged,
  });
  final PhoneController phoneController;
  final void Function(PhoneNumber?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return PhoneInput(
      countrySelectorNavigator: const CountrySelectorNavigator.dialog(),
      controller: phoneController,
      flagShape: BoxShape.rectangle,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0.r),
          borderSide: const BorderSide(color: AppColors.inputBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0.r),
          borderSide: const BorderSide(color: AppColors.primary),
        ),
      ),
      validator: PhoneValidator.validMobile(allowEmpty: false),
      onChanged: onChanged,
    );
  }
}
