import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../config/routes/app_routes.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_icons.dart';

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
            shape: const CircleBorder(),
            elevation: 0,
            backgroundColor: AppColors.grey,
            child: Image.asset(
              AppIcons.qrCode,
              height: 24.h,
              width: 24.h,
            ),
            onPressed: () {},
          ),
        ),
        SizedBox(height: 14.h),
        SizedBox(
          height: 64.h,
          width: 64.w,
          child: FloatingActionButton(
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
