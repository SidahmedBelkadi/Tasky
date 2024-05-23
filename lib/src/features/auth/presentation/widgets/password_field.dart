import 'package:flutter/material.dart';
import '../../../../core/common/widgets/app_text_form_field.dart';
import '../../../../core/utils/enums/input_type_enum.dart';
import '../../../../core/utils/resources/app_strings.dart';

class PasswordField extends StatelessWidget {
  final bool isObsecure;
  final VoidCallback toggleVisibility;
  final TextEditingController controller;

  const PasswordField({
    super.key,
    required this.isObsecure,
    required this.toggleVisibility,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return AppTextFormField(
      hint: AppStrings.password,
      suffixIcon: isObsecure ? Icons.visibility_outlined : Icons.visibility_off_outlined,
      onSuffixTap: toggleVisibility,
      textEditingController: controller,
      isObsecure: isObsecure,
      validationType: InputType.password,
      isRequired: true,
    );
  }
}
