import 'package:flutter/material.dart';

class AppTextFormField extends StatelessWidget {
  const AppTextFormField({
    super.key,
    required this.hint,
    this.textEditingController,
    this.suffixIcon,
    this.isObsecure = false,
  });

  final String hint;
  final TextEditingController? textEditingController;
  final IconData? suffixIcon;
  final bool isObsecure;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hint,
        suffixIcon: Icon(suffixIcon),
      ),
    );
  }
}
