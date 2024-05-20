import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_strings.dart';

class TaskStatus {
  final String name;
  final Color color;
  final Color backgroundColor;

  const TaskStatus._(this.name, this.color, this.backgroundColor);

  static const TaskStatus waiting = TaskStatus._(
    AppStrings.waiting,
    AppColors.waitingTextColor,
    AppColors.waittingBackgroundColor,
  );

  static const TaskStatus inProgress = TaskStatus._(
    AppStrings.waiting,
    AppColors.inProgressTextColor,
    AppColors.inProgressBackgroundColor,
  );

  static const TaskStatus finished = TaskStatus._(
    AppStrings.waiting,
    AppColors.finishedTextColor,
    AppColors.finishedBackgroundColor,
  );
}
