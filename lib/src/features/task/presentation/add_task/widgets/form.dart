import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/src/core/utils/enums/input_type_enum.dart';
import 'package:todo_app/src/core/utils/helpers/image_picker_helper.dart';
import 'package:todo_app/src/core/utils/helpers/media_query_values.dart';
import 'package:todo_app/src/core/utils/helpers/toast_helper.dart';
import 'package:todo_app/src/core/utils/resources/app_messages.dart';
import 'package:todo_app/src/features/task/domain/entities/task_entity.dart';
import 'package:todo_app/src/features/task/presentation/add_task/cubit/add_task_cubit.dart';
import 'package:todo_app/src/features/task/presentation/add_task/widgets/button.dart';
import '../../../../../core/common/widgets/app_text_form_field.dart';
import '../../../../../core/common/widgets/task_priority_drop_down.dart';
import '../../../../../core/utils/enums/task_priority_enum.dart';
import '../../../../../core/utils/resources/app_icons.dart';
import '../../../../../core/utils/resources/app_strings.dart';
import 'image_field.dart';
import 'label.dart';
import 'package:path/path.dart' as p;

class AddTaskForm extends StatefulWidget {
  const AddTaskForm({
    super.key,
  });

  @override
  State<AddTaskForm> createState() => _AddTaskFormState();
}

class _AddTaskFormState extends State<AddTaskForm> {
  File? _image;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  TaskPriority _selectedPriority = TaskPriority.medium;
  bool _imageError = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _pickImage() async {
    final image = await ImagePickerHelper().getImageFromGallery();
    setState(() {
      _image = image;
    });
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
          dateController.text = "${pickedDate.toLocal()}".split(' ')[0];
        });
      }
    }
  }

  void _submitForm() {
    bool isValidated = _formKey.currentState!.validate();
    if (!isValidated || _image == null) {
      setState(() {
        _imageError = !_imageError;
      });
      return;
    }

    final String fileName = "${DateTime.now().toString()}${p.extension(_image!.path)}";

    final taskEntity = TaskEntity(
        image: fileName,
        title: titleController.text.trim(),
        description: descController.text.trim(),
        priority: _selectedPriority.value);

    context.read<AddTaskCubit>().create(taskEntity: taskEntity);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Add Image
          _image != null
              ? Image.file(
                  _image!,
                  width: context.width,
                  height: 300.h,
                  fit: BoxFit.fill,
                )
              : AddTaskImageField(
                  onTap: _pickImage,
                  isError: _imageError,
                ),
          SizedBox(height: 12.h),

          /// Task Title
          const AddTaskLabel(text: AppStrings.taskTitle),
          SizedBox(height: 8.h),
          AppTextFormField(
            hint: AppStrings.enterTitle,
            textEditingController: titleController,
            validationType: InputType.name,
            isRequired: true,
          ),
          SizedBox(height: 12.h),

          /// Task Description
          const AddTaskLabel(text: AppStrings.taskDesc),
          SizedBox(height: 8.h),
          AppTextFormField(
            hint: AppStrings.enterDesc,
            textEditingController: descController,
            minLines: 5,
            maxLines: 7,
            validationType: InputType.name,
            isRequired: true,
          ),
          SizedBox(height: 12.h),

          /// Task Priority
          const AddTaskLabel(text: AppStrings.priority),
          SizedBox(height: 8.h),
          TaskPriorityDropDown(
            taskPriority: _selectedPriority,
            onChanged: (priority) {
              setState(() {
                _selectedPriority = priority!;
              });
            },
            items: TaskPriority.values,
          ),
          SizedBox(height: 12.h),

          /// Task Due Date
          const AddTaskLabel(text: AppStrings.dueDate),
          SizedBox(height: 8.h),
          AppTextFormField(
            readOnly: true,
            hint: AppStrings.chooseDueDate,
            textEditingController: dateController,
            suffixIcon: AppIcons.calendar,
            onSuffixTap: () => _selectDueDate(context),
            isRequired: true,
          ),
          SizedBox(height: 32.h),

          /// Task Detail Button
          BlocConsumer<AddTaskCubit, AddTaskState>(
            listener: (context, state) {
              if (state is AddTaskUnSuccessful) {
                AppToasts.showErrorToast(message: state.message, context: context);
              }
              if (state is AddTaskSuccessful) {
                AppToasts.showSuccessToast(message: AppMessages.taskAdded, context: context);
                Navigator.of(context).pop();
              }
            },
            builder: (context, state) {
              if (state is AddTaskLoading) {
                return AddTaskButton(
                  onPressed: () {},
                  isLoading: true,
                );
              }
              return AddTaskButton(
                onPressed: _submitForm,
              );
            },
          )
        ],
      ),
    );
  }
}
