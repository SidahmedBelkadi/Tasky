import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/common/widgets/app_text_form_field.dart';
import '../../../../../core/utils/enums/input_type_enum.dart';
import '../../../../../core/utils/resources/app_strings.dart';
import '../../widgets/password_field.dart';
import '../../widgets/phone_field.dart';
import '../cubit/sign_up_cubit.dart';
import 'drop_down.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  bool isObsecure = true;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignUpCubit>();
    return Form(
      key: cubit.formKey,
      child: Column(
        children: [
          AppTextFormField(
            hint: AppStrings.name,
            textEditingController: cubit.nameController,
            validationType: InputType.name,
            isRequired: true,
          ),
          SizedBox(height: 24.h),
          PhoneField(
            phoneController: cubit.phoneController,
            onChanged: (phone) => cubit.phoneController.value = phone,
          ),
          SizedBox(height: 24.h),
          const ExperienceLevelDropdown(),
          SizedBox(height: 24.h),
          AppTextFormField(
            hint: AppStrings.yearsOfExp,
            textEditingController: cubit.experienceYearsController,
            keyboardType: TextInputType.number,
            validationType: InputType.yearsOfExperience,
            isRequired: true,
          ),
          SizedBox(height: 24.h),
          AppTextFormField(
            hint: AppStrings.address,
            textEditingController: cubit.addressController,
            validationType: InputType.address,
            isRequired: true,
          ),
          SizedBox(height: 24.h),
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
