import 'package:flutter/material.dart';
import 'package:todo_app/src/core/common/widgets/button_loader.dart';

import '../../../../../core/common/widgets/app_elevated_button.dart';
import '../../../../../core/utils/resources/app_strings.dart';

class AddTaskButton extends StatelessWidget {
  const AddTaskButton({
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
          ? const ButtonCircularProgressIndicator(
              height: 32,
              width: 32,
            )
          : Text(
              AppStrings.addTask,
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontSize: 19,
                    color: Colors.white,
                  ),
            ),
    );
  }
}
