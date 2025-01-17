import 'package:flutter/material.dart';

import '../resources/app_colors.dart';
import '../resources/app_strings.dart';

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
    AppStrings.inProgress,
    AppColors.inProgressTextColor,
    AppColors.inProgressBackgroundColor,
  );

  static const TaskStatus finished = TaskStatus._(
    AppStrings.finished,
    AppColors.finishedTextColor,
    AppColors.finishedBackgroundColor,
  );

  static const List<TaskStatus> values = [waiting, inProgress, finished];
}

TaskStatus getTaskStatusFromString(String status) {
  switch (status.toLowerCase()) {
    case 'waiting':
      return TaskStatus.waiting;
    case 'inprogress':
      return TaskStatus.inProgress;
    case 'finished':
      return TaskStatus.finished;
    default:
      return TaskStatus.waiting;
  }
}
