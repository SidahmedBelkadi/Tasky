import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

import '../../../../core/common/widgets/app_bar.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_images.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/media_query_values.dart';
import 'widgets/description.dart';
import 'widgets/form.dart';
import 'widgets/title.dart';

class TaskDetailsScreen extends StatelessWidget {
  const TaskDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildTaskDetailAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Image
            Image.asset(
              AppImages.groceryBig,
              height: 250.sp,
              width: context.width,
            ),

            SizedBox(height: 8.h),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 22.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Title
                  const TaskDetailTitle(title: AppStrings.groceryShopApp),

                  SizedBox(height: 10.h),

                  /// Description
                  const TaskDetailDescription(
                    desc:
                        '${AppStrings.taskDetailDescriptionText} ${AppStrings.taskDetailDescriptionText} ${AppStrings.taskDetailDescriptionText} ${AppStrings.taskDetailDescriptionText} ${AppStrings.taskDetailDescriptionText} ${AppStrings.taskDetailDescriptionText} ${AppStrings.taskDetailDescriptionText}',
                  ),
                  SizedBox(height: 24.h),

                  /// Form
                  const TaskDetailForm(),

                  SizedBox(height: 32.h),

                  /// Qr Code
                  const TaskQrCode(data: AppStrings.dummyId),

                  SizedBox(height: 32.h),
                ],
              ),
            ),
          ],
        ),
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
