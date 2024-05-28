import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky/src/config/routes/app_routes.dart';
import 'package:tasky/src/core/utils/resources/app_colors.dart';
import 'package:tasky/src/core/utils/resources/app_icons.dart';

class CustomTasksScreenFloatingActionButtons extends StatelessWidget {
  const CustomTasksScreenFloatingActionButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 50.h,
          width: 50.w,
          child: FloatingActionButton(
            heroTag: 'qrCodeButton',
            shape: const CircleBorder(),
            elevation: 0,
            backgroundColor: AppColors.grey,
            child: Image.asset(
              AppIcons.qrCode,
              height: 24.h,
              width: 24.h,
            ),
            onPressed: () async {
              final taskId = await Navigator.of(context).pushNamed(Routes.qrCodeScanner);
              if (taskId != null) {
                Navigator.of(context).pushNamed(Routes.taskDetails, arguments: {'id': taskId});
              }
            },
          ),
        ),
        SizedBox(height: 14.h),
        SizedBox(
          height: 64.h,
          width: 64.w,
          child: FloatingActionButton(
            heroTag: 'addTaskButton',
            shape: const CircleBorder(),
            backgroundColor: AppColors.primary,
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: 32.sp,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(Routes.addTask);
            },
          ),
        ),
      ],
    );
  }
}
