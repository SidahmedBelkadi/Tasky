import 'package:flutter/material.dart';

import '../../../../../core/utils/resources/app_colors.dart';
import '../../../../../core/utils/resources/app_strings.dart';

class TasksHomeTitle extends StatelessWidget {
  const TasksHomeTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      AppStrings.tasks,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: AppColors.secondaryText,
          ),
    );
  }
}
