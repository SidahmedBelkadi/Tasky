import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/enums/task_status_enum.dart';
import '../../../../../core/utils/resources/app_strings.dart';

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
