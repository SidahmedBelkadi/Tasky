import 'package:flutter/material.dart';

import '../../../../../core/common/widgets/app_elevated_button.dart';
import '../../../../../core/utils/app_strings.dart';

class AddTaskButton extends StatelessWidget {
  const AddTaskButton({
    super.key,
    this.onPressed,
  });

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return AppElevatedButton(
      onPressed: onPressed,
      child: Text(
        AppStrings.addTask,
        style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              fontSize: 19,
              color: Colors.white,
            ),
      ),
    );
  }
}
