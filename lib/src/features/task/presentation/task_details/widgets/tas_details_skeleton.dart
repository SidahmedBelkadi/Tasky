import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tasky/src/core/common/widgets/app_text_form_field.dart';
import 'package:tasky/src/core/common/widgets/task_priority_drop_down.dart';
import 'package:tasky/src/core/common/widgets/task_status_drop_down.dart';
import 'package:tasky/src/core/utils/enums/task_priority_enum.dart';
import 'package:tasky/src/core/utils/enums/task_status_enum.dart';
import 'package:tasky/src/core/utils/helpers/media_query_values.dart';
import 'package:tasky/src/core/utils/resources/app_icons.dart';
import 'package:tasky/src/core/utils/resources/app_images.dart';
import 'package:tasky/src/core/utils/resources/app_strings.dart';
import 'package:tasky/src/features/task/presentation/task_details/widgets/description.dart';
import 'package:tasky/src/features/task/presentation/task_details/widgets/qr_code_skeleton.dart';
import 'package:tasky/src/features/task/presentation/task_details/widgets/title.dart';

class TaskDetailSkeleton extends StatelessWidget {
  const TaskDetailSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Image
          Image.asset(
            AppImages.imageSkeleton,
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
                const TaskDetailTitle(title: AppStrings.dummyTaskTitle),

                SizedBox(height: 10.h),

                /// Description
                const TaskDetailDescription(desc: AppStrings.dummyTastText),
                SizedBox(height: 24.h),

                /// Form
                AppTextFormField(
                  filled: true,
                  label: AppStrings.endDate,
                  suffixIcon: AppIcons.calendar,
                  textEditingController: TextEditingController(),
                ),
                SizedBox(height: 16.h),
                TaskStatusDropDown(
                  taskStatus: TaskStatus.finished,
                  onChanged: (status) {},
                  items: TaskStatus.values,
                ),
                SizedBox(height: 16.h),
                TaskPriorityDropDown(
                  taskPriority: TaskPriority.high,
                  onChanged: (priority) {},
                  items: TaskPriority.values,
                  showPrefixIcon: true,
                ),

                SizedBox(height: 32.h),

                /// Qr Code
                const QrCodeSkeleton(),

                SizedBox(height: 32.h),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
