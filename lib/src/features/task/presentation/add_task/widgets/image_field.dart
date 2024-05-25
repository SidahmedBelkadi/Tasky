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
    this.isError = false,
  });
  final void Function()? onTap;
  final bool isError;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: onTap,
          child: SizedBox(
            width: context.width,
            height: 56.sp,
            child: DottedBorder(
              color: isError ? Colors.red : AppColors.primary,
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
                      color: isError ? Colors.red : AppColors.primary,
                    ),
                    SizedBox(width: 5.w),
                    Text(
                      AppStrings.addImg,
                      style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                            fontSize: 19,
                            fontWeight: FontWeight.w500,
                            color: isError ? Colors.red : AppColors.primary,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        if (isError)
          const Column(
            children: [
              SizedBox(height: 8),
              Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  "The Task Image is required",
                  style: TextStyle(fontSize: 14, color: Colors.red),
                ),
              )
            ],
          ),
      ],
    );
  }
}
