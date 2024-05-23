import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/common/widgets/app_bar.dart';
import '../../../core/common/widgets/app_text_form_field.dart';
import '../../../core/utils/resources/app_icons.dart';
import '../../../core/utils/resources/app_strings.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomTasksAppBar(
        title: AppStrings.profile,
        showLeading: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 22.w),
          child: Column(
            children: [
              /// Name
              AppTextFormField(
                readOnly: true,
                filled: true,
                label: AppStrings.nameMaj,
                isBold: true,
                textEditingController: TextEditingController.fromValue(
                  const TextEditingValue(text: "30 june, 2022"),
                ),
              ),

              SizedBox(height: 16.h),

              /// Phone
              AppTextFormField(
                readOnly: true,
                filled: true,
                label: AppStrings.phone,
                suffixIcon: AppIcons.copy,
                isBold: true,
                textEditingController: TextEditingController.fromValue(
                  const TextEditingValue(text: "+213 669 89 61 93"),
                ),
              ),

              SizedBox(height: 16.h),

              /// Level
              AppTextFormField(
                readOnly: true,
                filled: true,
                label: AppStrings.level,
                isBold: true,
                textEditingController: TextEditingController.fromValue(
                  const TextEditingValue(text: "Senior"),
                ),
              ),

              SizedBox(height: 16.h),

              /// Years of exp
              AppTextFormField(
                readOnly: true,
                filled: true,
                label: AppStrings.yearsOfExpMaj,
                isBold: true,
                textEditingController: TextEditingController.fromValue(
                  const TextEditingValue(text: "8 years"),
                ),
              ),

              SizedBox(height: 16.h),

              /// Location
              AppTextFormField(
                readOnly: true,
                filled: true,
                label: AppStrings.location,
                isBold: true,
                textEditingController: TextEditingController.fromValue(
                  const TextEditingValue(text: "Boumerdes, Algeria"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
