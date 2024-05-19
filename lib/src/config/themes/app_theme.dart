import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'widgets_themes/elevated_button.dart';
import 'widgets_themes/text_theme.dart';

ThemeData appTheme() {
  return ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      brightness: Brightness.light,
    ),
    useMaterial3: true,
    fontFamily: GoogleFonts.dmSans().fontFamily,

    // Text
    textTheme: textTheme,
    // Button
    elevatedButtonTheme: elevatedButtonThemeData,
  );
}
