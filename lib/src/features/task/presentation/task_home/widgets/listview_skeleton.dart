import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tasky/src/core/utils/enums/task_priority_enum.dart';
import 'package:tasky/src/core/utils/enums/task_status_enum.dart';
import 'package:tasky/src/core/utils/resources/app_images.dart';
import 'package:tasky/src/core/utils/resources/app_strings.dart';
import 'package:tasky/src/features/task/presentation/task_home/widgets/task.dart';

class ListviewSkeleton extends StatelessWidget {
  const ListviewSkeleton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: ListView.builder(
        itemCount: 7,
        itemBuilder: (context, index) {
          return TaskItem(
            onTap: () {},
            taskImage: AppImages.grocery,
            isNetworkImage: false,
            taskTitle: AppStrings.dummyTaskTitle,
            taskDesc: AppStrings.dummyTastText,
            taskPriority: TaskPriority.high,
            taskStatus: TaskStatus.inProgress,
            taskDate: "11/03/2024",
          );
        },
      ),
    );
  }
}
