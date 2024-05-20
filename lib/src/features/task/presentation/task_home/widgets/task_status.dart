import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/task_status_enum.dart';

class TaskItemStatus extends StatelessWidget {
  const TaskItemStatus({
    super.key,
    required this.taskStatus,
  });

  final TaskStatus taskStatus;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 6.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.sp),
        color: taskStatus.backgroundColor,
      ),
      child: Text(
        AppStrings.waiting,
        style: Theme.of(context).textTheme.labelMedium!.copyWith(color: taskStatus.color),
      ),
    );
  }
}
