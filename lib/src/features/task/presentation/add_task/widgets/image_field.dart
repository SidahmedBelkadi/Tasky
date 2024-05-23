import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/helpers/media_query_values.dart';
import '../../../../../core/utils/resources/app_colors.dart';
import '../../../../../core/utils/resources/app_icons.dart';
import '../../../../../core/utils/resources/app_strings.dart';

class AddTaskImageField extends StatelessWidget {
  const AddTaskImageField({
    super.key,
    this.onTap,
  });
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: context.width,
        height: 56.sp,
        child: DottedBorder(
          color: AppColors.primary,
          strokeWidth: 1,
          radius: Radius.circular(12.sp),
          borderType: BorderType.RRect,
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  AppIcons.imageIcon,
                  height: 24.h,
                  width: 24.h,
                ),
                SizedBox(width: 5.w),
                Text(
                  AppStrings.addImg,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        fontSize: 19,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primary,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
