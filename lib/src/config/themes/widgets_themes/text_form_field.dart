import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/resources/app_colors.dart';

InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
  contentPadding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 20.h),
  labelStyle: TextStyle(
    fontSize: 9.sp,
    color: AppColors.secondaryText,
    fontWeight: FontWeight.w400,
  ),
  floatingLabelBehavior: FloatingLabelBehavior.auto,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12.0.r),
    borderSide: const BorderSide(color: AppColors.inputBorder),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12.0.r),
    borderSide: const BorderSide(color: AppColors.primary),
  ),
);
