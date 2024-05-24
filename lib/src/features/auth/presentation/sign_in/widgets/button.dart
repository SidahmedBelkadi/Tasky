import 'package:flutter/material.dart';

import '../../../../../core/common/widgets/app_elevated_button.dart';
import '../../../../../core/common/widgets/button_loader.dart';
import '../../../../../core/utils/resources/app_strings.dart';

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
      onPressed: onPressed,
      child: isLoading
          ? const ButtonCircularProgressIndicator(
              height: 32,
              width: 32,
            )
          : Text(
              AppStrings.signIn,
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: Colors.white,
                  ),
            ),
    );
  }
}
