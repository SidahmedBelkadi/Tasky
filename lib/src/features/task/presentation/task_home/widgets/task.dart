import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/enums/task_priority_enum.dart';
import '../../../../../core/utils/enums/task_status_enum.dart';
import '../../../../../core/utils/helpers/media_query_values.dart';
import '../../../../../core/utils/resources/app_icons.dart';
import 'task_description.dart';
import 'task_priority_and_date.dart';
import 'task_status.dart';
import 'task_title.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({
    super.key,
    this.onTap,
    required this.taskImage,
    required this.taskTitle,
    required this.taskDesc,
    required this.taskPriority,
    required this.taskStatus,
    required this.taskDate,
  });

  final void Function()? onTap;
  final String taskImage;
  final String taskTitle;
  final String taskDesc;
  final TaskPriority taskPriority;
  final TaskStatus taskStatus;
  final String taskDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.sp,
      width: context.width,
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            taskImage,
            height: 64.sp,
            width: 64.sp,
            fit: BoxFit.fill,
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TaskItemTitle(title: taskTitle),
                    TaskItemStatus(taskStatus: taskStatus),
                  ],
                ),
                TaskItemDescription(desc: taskDesc),
                TaskPriorityFlagAndDate(
                  priority: taskPriority,
                  date: taskDate,
                )
              ],
            ),
          ),
          SizedBox(width: 8.w),
          Align(
            alignment: Alignment.topCenter,
            child: GestureDetector(
              onTap: onTap,
              child: Image.asset(
                AppIcons.options,
                height: 24.h,
                width: 24.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
