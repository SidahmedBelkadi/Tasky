import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';

class TaskItemTitle extends StatelessWidget {
  const TaskItemTitle({
    super.key,
    required this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: AppColors.taskTitle),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
