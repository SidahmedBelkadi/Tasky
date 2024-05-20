import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/app_colors.dart';

class AppTextFormField extends StatelessWidget {
  const AppTextFormField({
    super.key,
    required this.hint,
    this.textEditingController,
    this.suffixIcon,
    this.isObsecure = false,
    this.suffixIconSize = 24,
    this.maxLines = 1,
    this.minLines = 1,
    this.filled = false,
    this.fillColor = AppColors.categorybackgroundColorGrey,
    this.onSuffixTap,
    this.readOnly = false,
  });

  final String hint;
  final TextEditingController? textEditingController;
  final dynamic suffixIcon;
  final bool isObsecure;
  final double suffixIconSize;
  final int maxLines;
  final int minLines;
  final bool filled;
  final Color fillColor;
  final void Function()? onSuffixTap;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isObsecure,
      readOnly: readOnly,
      controller: textEditingController,
      minLines: minLines,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        suffixIcon: suffixIcon != null ? _buildSuffixIcon() : null,
        filled: filled,
        fillColor: filled ? fillColor : null,
        border: filled ? _buildOutlineInputBorder(fillColor) : null,
        enabledBorder: filled ? _buildOutlineInputBorder(fillColor) : null,
        focusedBorder: filled ? _buildOutlineInputBorder(fillColor) : null,
      ),
    );
  }

  OutlineInputBorder _buildOutlineInputBorder(Color color) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: color),
      borderRadius: BorderRadius.circular(12.sp),
    );
  }

  Widget _buildSuffixIcon() {
    if (suffixIcon is IconData) {
      return GestureDetector(
        onTap: onSuffixTap,
        child: Icon(
          suffixIcon as IconData,
          size: suffixIconSize.sp,
        ),
      );
    } else if (suffixIcon is String) {
      return GestureDetector(
        onTap: onSuffixTap,
        child: Image.asset(
          suffixIcon as String,
          width: suffixIconSize.sp,
          height: suffixIconSize.sp,
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
