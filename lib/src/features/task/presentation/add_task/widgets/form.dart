import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/common/widgets/app_text_form_field.dart';
import '../../../../../core/common/widgets/task_priority_drop_down.dart';
import '../../../../../core/utils/app_icons.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/task_priority_enum.dart';
import 'image_field.dart';
import 'label.dart';

class AddTaskForm extends StatelessWidget {
  const AddTaskForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Add Image
          const AddTaskImageField(),
          SizedBox(height: 12.h),

          /// Task Title

          const AddTaskLabel(text: AppStrings.taskTitle),
          SizedBox(height: 8.h),
          const AppTextFormField(hint: AppStrings.enterTitle),
          SizedBox(height: 12.h),

          /// Task Description
          const AddTaskLabel(text: AppStrings.taskDesc),
          SizedBox(height: 8.h),
          const AppTextFormField(hint: AppStrings.enterDesc, minLines: 5, maxLines: 7),
          SizedBox(height: 12.h),

          /// Task Priority
          const AddTaskLabel(text: AppStrings.priority),
          SizedBox(height: 8.h),
          TaskPriorityDropDown(
            taskPriority: TaskPriority.medium,
            onChanged: (p0) {},
            items: TaskPriority.values,
          ),
          SizedBox(height: 12.h),

          /// Task Due Date
          const AddTaskLabel(text: AppStrings.dueDate),
          SizedBox(height: 12.h),
          AppTextFormField(
              readOnly: true,
              hint: AppStrings.chooseDueDate,
              suffixIcon: AppIcons.calendar,
              onSuffixTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (pickedDate != null) {
                  debugPrint("$pickedDate");
                  // Todo : Handle the selected date
                }
              }),
          SizedBox(height: 32.h),
        ],
      ),
    );
  }
}
