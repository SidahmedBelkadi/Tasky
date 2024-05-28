import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/routes/app_routes.dart';
import '../../../../../core/common/widgets/app_text_form_field.dart';
import '../../../../../core/common/widgets/task_priority_drop_down.dart';
import '../../../../../core/utils/enums/input_type_enum.dart';
import '../../../../../core/utils/enums/task_priority_enum.dart';
import '../../../../../core/utils/helpers/image_picker_helper.dart';
import '../../../../../core/utils/helpers/media_query_values.dart';
import '../../../../../core/utils/helpers/toast_helper.dart';
import '../../../../../core/utils/resources/app_icons.dart';
import '../../../../../core/utils/resources/app_messages.dart';
import '../../../../../core/utils/resources/app_strings.dart';
import '../../../domain/entities/task_entity.dart';
import '../cubit/add_task_cubit.dart';
import 'button.dart';
import 'image_field.dart';
import 'label.dart';

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

  /// Function of Pick Image
  Future<void> _pickImage() async {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Gallery'),
              onTap: () async {
                final image = await ImagePickerHelper().getImageFromGallery();
                setState(() {
                  _image = image;
                });
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_camera),
              title: const Text('Camera'),
              onTap: () async {
                final image = await ImagePickerHelper().getImageFromCamera();
                setState(() {
                  _image = image;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }

  /// Function For Date Selection
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
          AppToasts.showWarningToast(message: AppMessages.inferiorDateError, context: context);
        }
      } else {
        setState(() {
          dateController.text = "${pickedDateOnly.toLocal()}".split(' ')[0];
        });
      }
    }
  }

  /// Function For Submittion
  void _submitForm() {
    bool isValidated = _formKey.currentState!.validate();
    if (!isValidated || _image == null) {
      setState(() {
        _imageError = !_imageError;
      });
      return;
    }

    final taskEntity = TaskEntity(
        image: _image!.path,
        title: titleController.text.trim(),
        description: descController.text.trim(),
        priority: _selectedPriority.value);

    context.read<AddTaskCubit>().create(taskEntity: taskEntity, imageFile: _image!);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImageField(),
          SizedBox(height: 12.h),
          _buildTextField(
            label: AppStrings.taskTitle,
            controller: titleController,
            hint: AppStrings.enterTitle,
            validationType: InputType.name,
          ),
          SizedBox(height: 12.h),
          _buildTextField(
            label: AppStrings.taskDesc,
            controller: descController,
            hint: AppStrings.enterDesc,
            validationType: InputType.name,
            minLines: 5,
            maxLines: 7,
          ),
          SizedBox(height: 12.h),
          _buildPriorityDropdown(),
          SizedBox(height: 12.h),
          _buildDatePickerField(),
          SizedBox(height: 32.h),
          _buildSubmitButton(),
        ],
      ),
    );
  }

  Widget _buildImageField() {
    return _image != null
        ? Image.file(
            _image!,
            width: context.width,
            height: 300.h,
            fit: BoxFit.fill,
          )
        : AddTaskImageField(
            onTap: _pickImage,
            isError: _imageError,
          );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String hint,
    required InputType validationType,
    int minLines = 1,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AddTaskLabel(text: label),
        SizedBox(height: 8.h),
        AppTextFormField(
          hint: hint,
          textEditingController: controller,
          validationType: validationType,
          isRequired: true,
          minLines: minLines,
          maxLines: maxLines,
        ),
      ],
    );
  }

  Widget _buildPriorityDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
      ],
    );
  }

  Widget _buildDatePickerField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
      ],
    );
  }

  Widget _buildSubmitButton() {
    return BlocConsumer<AddTaskCubit, AddTaskState>(
      listener: (context, state) {
        if (state is AddTaskUnSuccessful) {
          AppToasts.showErrorToast(message: state.message, context: context);
        }
        if (state is AddTaskSuccessful) {
          AppToasts.showSuccessToast(message: AppMessages.taskAdded, context: context);
          Navigator.of(context).pushReplacementNamed(Routes.tasksHome);
        }
      },
      builder: (context, state) {
        return AddTaskButton(
          onPressed: state is AddTaskLoading ? () {} : _submitForm,
          isLoading: state is AddTaskLoading,
        );
      },
    );
  }
}
