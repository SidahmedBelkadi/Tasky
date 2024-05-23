import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/resources/app_strings.dart';
import 'category_item.dart';

class TaskCategoriesListView extends StatelessWidget {
  const TaskCategoriesListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.sp,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          const TaskCategoryItem(text: AppStrings.all, isSelected: true),
          SizedBox(width: 8.w),
          const TaskCategoryItem(text: AppStrings.waiting),
          SizedBox(width: 8.w),
          const TaskCategoryItem(text: AppStrings.inProgress),
          SizedBox(width: 8.w),
          const TaskCategoryItem(text: AppStrings.finished),
        ],
      ),
    );
  }
}
