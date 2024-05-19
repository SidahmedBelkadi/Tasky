import 'package:flutter/material.dart';
import '../../../core/utils/app_colors.dart';

ElevatedButtonThemeData elevatedButtonThemeData = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
    foregroundColor: Colors.white,
    backgroundColor: AppColors.primary,
  ),
);
