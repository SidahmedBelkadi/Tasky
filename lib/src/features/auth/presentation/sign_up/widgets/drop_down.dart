import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/resources/app_strings.dart';
import '../../../../../core/utils/validation/validation_messages.dart';
import '../cubit/sign_up_cubit.dart';

class ExperienceLevelDropdown extends StatelessWidget {
  const ExperienceLevelDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignUpCubit>();

    return DropdownButtonFormField(
      hint: const Text(
        AppStrings.chooseExpLevel,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (cubit.experienceLevel.isEmpty) {
          return ValidationErrorMessages.experienceLevel;
        }
        return null;
      },
      items: const [
        DropdownMenuItem(
          value: AppStrings.freshValue,
          child: Text(AppStrings.fresh),
        ),
        DropdownMenuItem(
          value: AppStrings.juniorValue,
          child: Text(AppStrings.junior),
        ),
        DropdownMenuItem(
          value: AppStrings.midLevelValue,
          child: Text(AppStrings.midLevel),
        ),
        DropdownMenuItem(
          value: AppStrings.seniorValue,
          child: Text(AppStrings.senior),
        ),
      ],
      onChanged: (value) {
        cubit.experienceLevel = value as String;
      },
    );
  }
}
