import 'package:flutter/material.dart';

import '../../../../core/common/widgets/app_elevated_button.dart';
import '../../../../core/utils/app_strings.dart';

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
