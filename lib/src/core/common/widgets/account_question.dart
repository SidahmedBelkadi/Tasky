import 'package:flutter/material.dart';
import 'package:todo_app/src/core/utils/app_colors.dart';
import 'package:todo_app/src/core/utils/app_strings.dart';

class AccountQuestion extends StatelessWidget {
  const AccountQuestion({
    super.key,
    required this.text,
    required this.buttonText,
    this.onPressed,
  });

  final String text;
  final String buttonText;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            AppStrings.dontHaveAccount,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: AppColors.secondaryText,
                ),
          ),
          TextButton(
            onPressed: onPressed,
            child: Text(
              AppStrings.signUpHere,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: AppColors.primary,
                    decoration: TextDecoration.underline,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
