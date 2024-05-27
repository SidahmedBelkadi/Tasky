import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/api/end_points.dart';
import '../../../../core/common/widgets/button_loader.dart';
import '../../../../core/utils/helpers/toast_helper.dart';
import '../../../../core/utils/resources/app_messages.dart';
import '../../domain/entities/task_entity.dart';
import 'cubit/task_detail_cubit.dart';

import '../../../../core/common/widgets/app_bar.dart';
import '../../../../core/utils/helpers/media_query_values.dart';
import '../../../../core/utils/resources/app_colors.dart';
import '../../../../core/utils/resources/app_strings.dart';
import 'widgets/description.dart';
import 'widgets/form.dart';
import 'widgets/title.dart';

class TaskDetailsScreen extends StatefulWidget {
  const TaskDetailsScreen({super.key});

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  late TaskEntity task;
  late String taskId;

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
              if (state is DeleteTaskLoading) {
                return const ButtonCircularProgressIndicator(height: 16, width: 16);
              }
              return PopupMenuButton(
                onSelected: (value) {
                  if (value == AppStrings.edit.toLowerCase()) {
                    // Hanlde if edit
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
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Image
                  Image.network(
                    "${EndPoints.baseUrl}/images/${task.image}",
                    height: 250.sp,
                    width: context.width,
                    fit: BoxFit.fill,
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
                        TaskDetailForm(task: task),

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
          } else if (state is GetTaskDetailUnSuccessful) {
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
        },
      ),
    );
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
