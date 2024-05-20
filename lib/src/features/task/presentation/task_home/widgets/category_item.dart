import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/utils/app_colors.dart';

class TaskCategoryItem extends StatelessWidget {
  const TaskCategoryItem({
    super.key,
    required this.text,
    this.isSelected = false,
  });

  final String text;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36.h,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.sp),
        color: isSelected ? AppColors.primary : AppColors.categorybackgroundColorGrey,
      ),
      child: Center(
        child: Text(
          text,
          style: isSelected
              ? Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  )
              : Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: AppColors.categoryTextColorGrey,
                  ),
        ),
      ),
    );
  }
}
