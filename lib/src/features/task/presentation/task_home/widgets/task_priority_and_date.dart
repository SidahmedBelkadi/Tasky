import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/enums/task_priority_enum.dart';
import '../../../../../core/utils/resources/app_colors.dart';
import '../../../../../core/utils/resources/app_icons.dart';

class TaskPriorityFlagAndDate extends StatelessWidget {
  const TaskPriorityFlagAndDate({
    super.key,
    required this.priority,
    required this.date,
  });

  final TaskPriority priority;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Image.asset(
              AppIcons.flag,
              height: 16.h,
              width: 16.h,
              color: priority.color,
            ),
            SizedBox(width: 3.w),
            Text(
              priority.name,
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: priority.color,
                  ),
            ),
          ],
        ),
        Text(
          date,
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: AppColors.taskTitle,
                fontWeight: FontWeight.w400,
                height: 1.5,
              ),
        )
      ],
    );
  }
}
