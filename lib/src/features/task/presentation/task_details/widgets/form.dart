import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/src/features/task/domain/entities/task_entity.dart';

import '../../../../../core/common/widgets/app_text_form_field.dart';
import '../../../../../core/common/widgets/task_priority_drop_down.dart';
import '../../../../../core/common/widgets/task_status_drop_down.dart';
import '../../../../../core/utils/enums/task_priority_enum.dart';
import '../../../../../core/utils/enums/task_status_enum.dart';
import '../../../../../core/utils/resources/app_icons.dart';
import '../../../../../core/utils/resources/app_strings.dart';

class TaskDetailForm extends StatefulWidget {
  const TaskDetailForm({
    super.key,
    required this.task,
  });

  final TaskEntity task;

  @override
  State<TaskDetailForm> createState() => _TaskDetailFormState();
}

TextEditingController dateController = TextEditingController();

class _TaskDetailFormState extends State<TaskDetailForm> {
  @override
  void initState() {
    super.initState();
    dateController.text = widget.task.formattedUpdatedAt;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          AppTextFormField(
            filled: true,
            label: AppStrings.endDate,
            suffixIcon: AppIcons.calendar,
            textEditingController: dateController,
          ),
          SizedBox(height: 16.h),
          TaskStatusDropDown(
            taskStatus: getTaskStatusFromString(widget.task.status!),
            onChanged: (p0) {},
            items: TaskStatus.values,
          ),
          SizedBox(height: 16.h),
          TaskPriorityDropDown(
            taskPriority: getTaskPriorityFromString(widget.task.priority),
            onChanged: (p0) {},
            items: TaskPriority.values,
            showPrefixIcon: true,
          ),
        ],
      ),
    );
  }
}
