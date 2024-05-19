import 'package:flutter/material.dart';
import 'package:todo_app/src/core/common/widgets/app_elevated_button.dart';
import 'package:todo_app/src/core/utils/app_strings.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({
    super.key,
    this.onPressed,
  });

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return AppElevatedButton(
      onPressed: onPressed,
      child: Text(
        AppStrings.signUp,
        style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.white),
      ),
    );
  }
}
