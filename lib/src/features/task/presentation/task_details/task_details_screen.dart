import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:todo_app/src/core/api/end_points.dart';
import 'package:todo_app/src/features/task/domain/entities/task_entity.dart';
import 'package:todo_app/src/features/task/presentation/task_details/cubit/task_detail_cubit.dart';

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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final cubit = context.read<TaskDetailCubit>();
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final taskId = args?['id'];

    if (taskId != null) {
      cubit.getTaskDetails(taskId: taskId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildTaskDetailAppBar(),
      body: BlocBuilder<TaskDetailCubit, TaskDetailState>(
        builder: (context, state) {
          if (state is GetTaskDetailLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetTaskDetailSuccessful) {
            task = state.taskEntity;
            return buildTaskDetails(context, task: task);
          } else if (state is GetTaskDetailUnSuccessful) {
            return Center(child: Text(state.message));
          }
          return const SizedBox();
        },
      ),
    );
  }

  SingleChildScrollView buildTaskDetails(BuildContext context, {required TaskEntity task}) {
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
  }

  /// Function That build the appbar
  CustomTasksAppBar buildTaskDetailAppBar() {
    return CustomTasksAppBar(
      title: AppStrings.taskDetails,
      showLeading: true,
      actions: [
        PopupMenuButton(
          itemBuilder: (context) => [
            PopupMenuItem(
              child: Text(
                AppStrings.edit,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              onTap: () {},
            ),
            PopupMenuItem(
              child: Text(
                AppStrings.delete,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: AppColors.waitingTextColor,
                    ),
              ),
              onTap: () {},
            ),
          ],
        ),
      ],
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
