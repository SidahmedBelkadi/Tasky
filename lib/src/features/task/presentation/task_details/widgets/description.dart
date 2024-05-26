import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:readmore/readmore.dart';

import '../../../../../core/utils/resources/app_colors.dart';
import '../../../../../core/utils/resources/app_strings.dart';

class TaskDetailDescription extends StatelessWidget {
  const TaskDetailDescription({
    super.key,
    required this.desc,
  });

  final String desc;

  @override
  Widget build(BuildContext context) {
    return ReadMoreText(
      desc,
      trimLines: 2,
      trimMode: TrimMode.Line,
      trimCollapsedText: AppStrings.showMore,
      trimExpandedText: AppStrings.showLess,
      style: Theme.of(context).textTheme.bodySmall!.copyWith(
            color: AppColors.secondaryText,
          ),
      moreStyle: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w800,
        color: AppColors.primary,
      ),
      lessStyle: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w800,
        color: AppColors.primary,
      ),
    );
  }
}
