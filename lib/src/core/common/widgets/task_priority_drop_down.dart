import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/enums/task_priority_enum.dart';
import '../../utils/resources/app_colors.dart';
import '../../utils/resources/app_icons.dart';
import '../../utils/resources/app_strings.dart';

class TaskPriorityDropDown extends StatelessWidget {
  const TaskPriorityDropDown({
    super.key,
    required this.taskPriority,
    required this.onChanged,
    required this.items,
    this.showPrefixIcon = true,
  });

  final TaskPriority taskPriority;
  final void Function(TaskPriority?)? onChanged;
  final List<TaskPriority> items;
  final bool showPrefixIcon;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      hint: Text(
        '${taskPriority.name} ${AppStrings.priority}',
        style: TextStyle(
          color: taskPriority.color,
          fontWeight: FontWeight.bold,
        ),
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.categorybackgroundColorGrey,
        prefixIcon: showPrefixIcon
            ? Image.asset(
                AppIcons.flag,
                height: 24.h,
                width: 24.h,
                color: taskPriority.color,
              )
            : null,
        suffixIcon: Image.asset(
          AppIcons.arrowDown,
          height: 24.h,
          width: 24.h,
          color: taskPriority.color,
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
      items: items.map((priority) {
        return DropdownMenuItem<TaskPriority>(
          value: priority,
          child: Text(
            "${priority.name} ${AppStrings.priority}",
            style: TextStyle(
              color: priority.color,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
