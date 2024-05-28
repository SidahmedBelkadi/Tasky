import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import '../../../../core/api/end_points.dart';
import '../../../../core/common/widgets/app_text_form_field.dart';
import '../../../../core/common/widgets/button_loader.dart';
import '../../../../core/common/widgets/task_priority_drop_down.dart';
import '../../../../core/common/widgets/task_status_drop_down.dart';
import '../../../../core/utils/enums/task_priority_enum.dart';
import '../../../../core/utils/enums/task_status_enum.dart';
import '../../../../core/utils/helpers/media_query_values.dart';
import '../../../../core/utils/helpers/toast_helper.dart';
import '../../../../core/utils/resources/app_colors.dart';
import '../../../../core/utils/resources/app_icons.dart';
import '../../../../core/utils/resources/app_messages.dart';
import '../../../../core/utils/resources/app_strings.dart';
import 'cubit/task_detail_cubit.dart';
import 'widgets/description.dart';
import 'widgets/title.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/common/widgets/app_bar.dart';

import '../../domain/entities/task_entity.dart';

class TaskDetailsScreen extends StatefulWidget {
  const TaskDetailsScreen({super.key});

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  late TaskEntity task;
  late String taskId;

  final TextEditingController dateController = TextEditingController();
  String? taskStatus;
  String? taskPriority;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      taskId = args?['id'];
      context.read<TaskDetailCubit>().getTaskDetails(taskId: taskId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomTasksAppBar(
        title: AppStrings.taskDetails,
        showLeading: true,
        actions: [
          BlocConsumer<TaskDetailCubit, TaskDetailState>(
            builder: (context, state) {
              if (state is DeleteTaskLoading || state is UpdateTaskLoading) {
                return const ButtonCircularProgressIndicator(height: 16, width: 16);
              }
              return PopupMenuButton(
                onSelected: (value) {
                  if (value == AppStrings.edit.toLowerCase()) {
                    _updateTask(context);
                  } else if (value == AppStrings.delete.toLowerCase()) {
                    context.read<TaskDetailCubit>().deleteTask(taskId: taskId);
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: AppStrings.edit.toLowerCase(),
                    child: Text(
                      AppStrings.edit,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  PopupMenuItem(
                    value: AppStrings.delete.toLowerCase(),
                    child: Text(
                      AppStrings.delete,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: AppColors.waitingTextColor,
                          ),
                    ),
                  ),
                ],
              );
            },
            listener: (context, state) {
              if (state is DeleteTaskSuccessful) {
                Navigator.of(context).pushReplacementNamed(Routes.tasksHome);
              }
              if (state is DeleteTaskUnSuccessful) {
                AppToasts.showErrorToast(message: state.message, context: context);
              }
              if (state is UpdateTaskSuccessful) {
                Navigator.of(context).pushReplacementNamed(Routes.tasksHome);
              }
              if (state is UpdateTaskUnSuccessful) {
                AppToasts.showErrorToast(message: state.message, context: context);
              }
            },
          ),
        ],
      ),
      body: BlocConsumer<TaskDetailCubit, TaskDetailState>(
        builder: (context, state) {
          if (state is GetTaskDetailLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetTaskDetailSuccessful) {
            task = state.taskEntity;
            dateController.text = task.formattedUpdatedAt;
            taskStatus ??= task.status!;
            taskPriority ??= task.priority;

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Image
                  Image.network(
                    "${EndPoints.baseUrl}/images/${task.image}",
                    height: 250.sp,
                    width: context.width,
                    fit: BoxFit.cover,
                  ),

                  SizedBox(height: 8.h),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 22.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Title
                        TaskDetailTitle(title: task.title),

                        SizedBox(height: 10.h),

                        /// Description
                        TaskDetailDescription(desc: task.description),
                        SizedBox(height: 24.h),

                        /// Form
                        AppTextFormField(
                          filled: true,
                          label: AppStrings.endDate,
                          suffixIcon: AppIcons.calendar,
                          onSuffixTap: () => _selectDueDate(context),
                          textEditingController: dateController,
                        ),
                        SizedBox(height: 16.h),
                        TaskStatusDropDown(
                          taskStatus: getTaskStatusFromString(taskStatus!),
                          onChanged: (status) {
                            setState(() {
                              taskStatus = status!.name;
                            });
                          },
                          items: TaskStatus.values,
                        ),
                        SizedBox(height: 16.h),
                        TaskPriorityDropDown(
                          taskPriority: getTaskPriorityFromString(taskPriority!),
                          onChanged: (priority) {
                            setState(() {
                              taskPriority = priority!.name;
                            });
                          },
                          items: TaskPriority.values,
                          showPrefixIcon: true,
                        ),

                        SizedBox(height: 32.h),

                        /// Qr Code
                        TaskQrCode(data: task.id ?? ''),

                        SizedBox(height: 32.h),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else if (state is GetTaskDetailUnSuccessful ||
              state is DeleteTaskUnSuccessful ||
              state is UpdateTaskUnSuccessful) {
            return Padding(
              padding: EdgeInsets.all(16.sp),
              child: Center(
                child: Text(
                  AppMessages.errorDuringCommunication,
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          return const SizedBox();
        },
        listener: (BuildContext context, TaskDetailState state) {
          if (state is GetTaskDetailUnSuccessful) {
            AppToasts.showErrorToast(message: state.message, context: context);
          }
          if (state is UpdateTaskSuccessful) {
            AppToasts.showSuccessToast(message: AppStrings.taskUpdated, context: context);
          }
        },
      ),
    );
  }

  void _updateTask(BuildContext context) {
    final updatedTask = task.copyWith(
      status: taskStatus,
      priority: taskPriority,
      updatedAt: DateTime.now().toIso8601String(),
    );
    context.read<TaskDetailCubit>().updateTask(task: updatedTask);
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
          dateController.text = "${pickedDateOnly.toLocal()}".split(' ')[0];
        });
      }
    }
  }
}

class TaskQrCode extends StatelessWidget {
  const TaskQrCode({
    super.key,
    required this.data,
  });

  final String data;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 320.h,
        width: 320.w,
        padding: EdgeInsets.all(12.sp),
        child: PrettyQrView.data(
          data: data,
        ),
      ),
    );
  }
}
