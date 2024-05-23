import 'package:flutter/material.dart';

import '../../../../../core/common/widgets/app_elevated_button.dart';
import '../../../../../core/common/widgets/button_loader.dart';
import '../../../../../core/utils/resources/app_strings.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({
    super.key,
    this.onPressed,
    this.isLoading = false,
  });

  final void Function()? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return AppElevatedButton(
      onPressed: onPressed,
      child: isLoading
          ? const ButtonCircularProgressIndicator()
          : Text(
              AppStrings.signUp,
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.white),
            ),
    );
  }
}
