import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/utils/resources/app_colors.dart';
import 'widgets_themes/app_bar.dart';
import 'widgets_themes/elevated_button.dart';
import 'widgets_themes/text_form_field.dart';
import 'widgets_themes/text_theme.dart';

ThemeData appTheme() {
  return ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      brightness: Brightness.light,
    ),
    useMaterial3: true,
    fontFamily: GoogleFonts.dmSans().fontFamily,

    /// Texts Theme
    textTheme: textTheme,

    /// Button Theme
    elevatedButtonTheme: elevatedButtonThemeData,

    /// Form Field Theme
    inputDecorationTheme: inputDecorationTheme,

    /// AppBar Theme
    appBarTheme: appBarTheme,

    /// Date Picker
    datePickerTheme: const DatePickerThemeData(
      rangeSelectionBackgroundColor: AppColors.primary,
    ),

    /// Popup Menu Theme
    popupMenuTheme: PopupMenuThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.sp),
      ),
      color: Colors.white,
    ),
  );
}
