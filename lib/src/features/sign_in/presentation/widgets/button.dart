import 'package:flutter/material.dart';
import 'package:todo_app/src/core/common/widgets/app_elevated_button.dart';
import 'package:todo_app/src/core/utils/app_strings.dart';

class SignInButton extends StatelessWidget {
  const SignInButton({
    super.key,
    this.isLoading = false,
    this.onPressed,
  });

  final bool isLoading;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return AppElevatedButton(
      onPressed: () {},
      child: Text(
        AppStrings.signIn,
        style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              color: Colors.white,
            ),
      ),
    );
  }
}
