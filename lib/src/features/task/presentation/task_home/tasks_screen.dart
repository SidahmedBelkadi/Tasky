import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_images.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/task_priority_enum.dart';
import 'widgets/app_bar.dart';
import 'widgets/categories_listview.dart';
import 'widgets/task.dart';
import 'widgets/title.dart';

import '../../../../core/utils/task_status_enum.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TasksHomeAppBar(),
      body: Padding(
        padding: EdgeInsets.all(22.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Tasks Title
            const TasksHomeTitle(),

            SizedBox(height: 8.h),

            /// Categories ListView
            const TaskCategoriesListView(),

            SizedBox(height: 32.h),

            /// Tasks ListView
            const Expanded(
              child: TasksListView(),
            ),
          ],
        ),
      ),
    );
  }
}

class TasksListView extends StatelessWidget {
  const TasksListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        TaskItem(
          taskImage: AppImages.grocery,
          taskTitle: AppStrings.dummyTaskTitle,
          taskDesc: AppStrings.dummyTastText,
          taskPriority: TaskPriority.medium,
          taskStatus: TaskStatus.waiting,
          taskDate: '31/12/2022',
        ),
        TaskItem(
          taskImage: AppImages.grocery,
          taskTitle: AppStrings.dummyTaskTitle,
          taskDesc: AppStrings.dummyTastText,
          taskPriority: TaskPriority.low,
          taskStatus: TaskStatus.waiting,
          taskDate: '31/12/2022',
        ),
        TaskItem(
          taskImage: AppImages.grocery,
          taskTitle: AppStrings.dummyTaskTitle,
          taskDesc: AppStrings.dummyTastText,
          taskPriority: TaskPriority.high,
          taskStatus: TaskStatus.inProgress,
          taskDate: '31/12/2022',
        ),
        TaskItem(
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
