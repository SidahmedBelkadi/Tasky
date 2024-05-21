import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_icons.dart';
import '../../utils/task_status_enum.dart';

class TaskStatusDropDown extends StatelessWidget {
  const TaskStatusDropDown({
    super.key,
    required this.taskStatus,
    required this.onChanged,
    required this.items,
  });

  final TaskStatus taskStatus;
  final void Function(TaskStatus?)? onChanged;
  final List<TaskStatus> items;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      hint: Text(
        taskStatus.name,
        style: TextStyle(
          color: taskStatus.color,
          fontWeight: FontWeight.bold,
        ),
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.categorybackgroundColorGrey,
        suffixIcon: Image.asset(
          AppIcons.arrowDown,
          height: 24.h,
          width: 24.h,
          color: taskStatus.color,
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.categorybackgroundColorGrey),
          borderRadius: BorderRadius.circular(12.sp),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.categorybackgroundColorGrey),
          borderRadius: BorderRadius.circular(12.sp),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.categorybackgroundColorGrey),
          borderRadius: BorderRadius.circular(12.sp),
        ),
      ),
      iconSize: 0,
      items: items.map((status) {
        return DropdownMenuItem<TaskStatus>(
          value: status,
          child: Text(status.name),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
