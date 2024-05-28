import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky/src/core/utils/resources/app_images.dart';

class QrCodeSkeleton extends StatelessWidget {
  const QrCodeSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 320.h,
        width: 320.w,
        padding: EdgeInsets.all(12.sp),
        child: Image.asset(
          AppImages.imageSkeleton,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
