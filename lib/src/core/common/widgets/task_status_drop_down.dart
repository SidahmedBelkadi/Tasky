import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/enums/task_status_enum.dart';
import '../../utils/resources/app_colors.dart';
import '../../utils/resources/app_icons.dart';

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
          child: Text(
            status.name,
            style: TextStyle(
              color: status.color,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
