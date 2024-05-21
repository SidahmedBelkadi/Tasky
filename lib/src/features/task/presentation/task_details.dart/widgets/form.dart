import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/common/widgets/app_text_form_field.dart';
import '../../../../../core/common/widgets/task_priority_drop_down.dart';
import '../../../../../core/common/widgets/task_status_drop_down.dart';
import '../../../../../core/utils/app_icons.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/task_priority_enum.dart';
import '../../../../../core/utils/task_status_enum.dart';

class TaskDetailForm extends StatelessWidget {
  const TaskDetailForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          AppTextFormField(
            filled: true,
            label: AppStrings.endDate,
            suffixIcon: AppIcons.calendar,
            textEditingController: TextEditingController.fromValue(
              const TextEditingValue(text: "30 june, 2022"),
            ),
          ),
          SizedBox(height: 16.h),
          TaskStatusDropDown(
            taskStatus: TaskStatus.inProgress,
            onChanged: (p0) {},
            items: TaskStatus.values,
          ),
          SizedBox(height: 16.h),
          TaskPriorityDropDown(
            taskPriority: TaskPriority.medium,
            onChanged: (p0) {},
            items: TaskPriority.values,
            showPrefixIcon: true,
          ),
        ],
      ),
    );
  }
}
