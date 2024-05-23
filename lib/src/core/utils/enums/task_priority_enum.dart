import 'package:flutter/material.dart';

import '../resources/app_colors.dart';
import '../resources/app_strings.dart';

class TaskPriority {
  final String name;
  final Color color;

  const TaskPriority._(this.name, this.color);

  static const TaskPriority low = TaskPriority._(
    AppStrings.low,
    AppColors.lowProiorityColor,
  );
  static const TaskPriority medium = TaskPriority._(
    AppStrings.medium,
    AppColors.mediumProiorityColor,
  );
  static const TaskPriority high = TaskPriority._(
    AppStrings.heigh,
    AppColors.highProiorityColor,
  );

  static const List<TaskPriority> values = [low, medium, high];
}
