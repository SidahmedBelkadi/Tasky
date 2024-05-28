import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/common/widgets/app_text_form_field.dart';
import '../../../../../core/common/widgets/task_priority_drop_down.dart';
import '../../../../../core/common/widgets/task_status_drop_down.dart';
import '../../../../../core/utils/enums/task_priority_enum.dart';
import '../../../../../core/utils/enums/task_status_enum.dart';
import '../../../../../core/utils/helpers/toast_helper.dart';
import '../../../../../core/utils/resources/app_icons.dart';
import '../../../../../core/utils/resources/app_messages.dart';
import '../../../../../core/utils/resources/app_strings.dart';
import '../../../domain/entities/task_entity.dart';

class TaskDetailForm extends StatefulWidget {
  const TaskDetailForm({
    super.key,
    required this.task,
    required this.dateController,
    required this.onStatusChanged,
    required this.onPriorityChanged,
  });

  final TaskEntity task;
  final TextEditingController dateController;
  final ValueChanged<String> onStatusChanged;
  final ValueChanged<String> onPriorityChanged;

  @override
  State<TaskDetailForm> createState() => _TaskDetailFormState();
}

class _TaskDetailFormState extends State<TaskDetailForm> {
  late String taskStatus;
  late String taskPriority;

  @override
  void initState() {
    super.initState();
    taskStatus = widget.task.status!;
    taskPriority = widget.task.priority;
  }

  Future<void> _selectDueDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      final today = DateTime.now();
      final pickedDateOnly = DateTime(pickedDate.year, pickedDate.month, pickedDate.day);
      final todayOnly = DateTime(today.year, today.month, today.day);

      if (pickedDateOnly.isBefore(todayOnly)) {
        if (mounted) {
          AppToasts.showErrorToast(message: AppMessages.inferiorDateError, context: context);
        }
      } else {
        setState(() {
          widget.dateController.text = "${pickedDateOnly.toLocal()}".split(' ')[0];
        });
      }
    }
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
            onSuffixTap: () => _selectDueDate(context),
            textEditingController: widget.dateController,
          ),
          SizedBox(height: 16.h),
          TaskStatusDropDown(
            taskStatus: getTaskStatusFromString(taskStatus),
            onChanged: (status) {
              setState(() {
                taskStatus = status!.name;
                widget.onStatusChanged(taskStatus);
              });
            },
            items: TaskStatus.values,
          ),
          SizedBox(height: 16.h),
          TaskPriorityDropDown(
            taskPriority: getTaskPriorityFromString(taskPriority),
            onChanged: (priority) {
              setState(() {
                taskPriority = priority!.name;
                widget.onPriorityChanged(taskPriority);
              });
            },
            items: TaskPriority.values,
            showPrefixIcon: true,
          ),
        ],
      ),
    );
  }
}
