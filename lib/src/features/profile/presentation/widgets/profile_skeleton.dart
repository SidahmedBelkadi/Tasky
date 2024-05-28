import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tasky/src/core/common/widgets/app_text_form_field.dart';
import 'package:tasky/src/core/utils/resources/app_icons.dart';
import 'package:tasky/src/core/utils/resources/app_strings.dart';

class ProfileSkeleton extends StatelessWidget {
  const ProfileSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: SingleChildScrollView(
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
                  const TextEditingValue(text: "Sidahmed Belkadi"),
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
                  const TextEditingValue(text: "6 Years"),
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
                  const TextEditingValue(text: "Boumerdes, Algiers, Algiera"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
