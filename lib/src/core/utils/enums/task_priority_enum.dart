import 'package:flutter/material.dart';

import '../resources/app_colors.dart';
import '../resources/app_strings.dart';

class TaskPriority {
  final String name;
  final String value;

  final Color color;

  const TaskPriority._(this.name, this.color, this.value);

  static const TaskPriority low = TaskPriority._(
    AppStrings.low,
    AppColors.lowProiorityColor,
    AppStrings.lowValue,
  );
  static const TaskPriority medium = TaskPriority._(
    AppStrings.medium,
    AppColors.mediumProiorityColor,
    AppStrings.mediumValue,
  );
  static const TaskPriority high = TaskPriority._(
    AppStrings.heigh,
    AppColors.highProiorityColor,
    AppStrings.highValue,
  );

  static const List<TaskPriority> values = [low, medium, high];
}

TaskPriority getTaskPriorityFromString(String priority) {
  switch (priority.toLowerCase()) {
    case 'low':
      return TaskPriority.low;
    case 'medium':
      return TaskPriority.medium;
    case 'high':
      return TaskPriority.high;
    default:
      return TaskPriority.medium;
  }
}
