import 'package:flutter/material.dart';

import '../../../../../config/routes/app_routes.dart';
import '../../../../../core/utils/enums/task_priority_enum.dart';
import '../../../../../core/utils/enums/task_status_enum.dart';
import '../../../../../core/utils/resources/app_images.dart';
import '../../../../../core/utils/resources/app_strings.dart';
import 'task.dart';

class TasksListView extends StatelessWidget {
  const TasksListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        TaskItem(
          onTap: () {
            Navigator.of(context).pushNamed(Routes.taskDetails);
          },
          taskImage: AppImages.grocery,
          taskTitle: AppStrings.dummyTaskTitle,
          taskDesc: AppStrings.dummyTastText,
          taskPriority: TaskPriority.medium,
          taskStatus: TaskStatus.waiting,
          taskDate: '31/12/2022',
        ),
        const TaskItem(
          taskImage: AppImages.grocery,
          taskTitle: AppStrings.dummyTaskTitle,
          taskDesc: AppStrings.dummyTastText,
          taskPriority: TaskPriority.low,
          taskStatus: TaskStatus.waiting,
          taskDate: '31/12/2022',
        ),
        const TaskItem(
          taskImage: AppImages.grocery,
          taskTitle: AppStrings.dummyTaskTitle,
          taskDesc: AppStrings.dummyTastText,
          taskPriority: TaskPriority.high,
          taskStatus: TaskStatus.inProgress,
          taskDate: '31/12/2022',
        ),
        const TaskItem(
          taskImage: AppImages.grocery,
          taskTitle: AppStrings.dummyTaskTitle,
          taskDesc: AppStrings.dummyTastText,
          taskPriority: TaskPriority.medium,
          taskStatus: TaskStatus.finished,
          taskDate: '31/12/2022',
        )
      ],
    );
  }
}
