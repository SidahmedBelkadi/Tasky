import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const primary = Color(0xff5F33E1);
  static const inputBorder = Color(0xffBABABA);
  static const secondaryText = Color(0xff6E6A7C);
  static const categoryTextColorGrey = Color(0xff7C7C80);
  static const categorybackgroundColorGrey = Color(0xffF0ECFF);
  // ignore: use_full_hex_values_for_flutter_colors
  static const taskDescription = Color(0xff24252C99);
  static const taskTitle = Color(0xff24252C);
  static const waitingTextColor = Color(0xffFF7D53);
  static const inProgressTextColor = primary;
  static const finishedTextColor = Color(0xff0087FF);
  static const inProgressBackgroundColor = categorybackgroundColorGrey;
  static const waittingBackgroundColor = Color(0xffFFE4F2);
  static const finishedBackgroundColor = Color(0xffE3F2FF);
  static const highProiorityColor = waitingTextColor;
  static const mediumProiorityColor = primary;
  static const lowProiorityColor = Color(0xff0087FF);
}
