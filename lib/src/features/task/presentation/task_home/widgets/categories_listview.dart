import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/resources/app_strings.dart';
import '../cubit/tasks_cubit.dart';
import 'category_item.dart';

class TaskCategoriesListView extends StatelessWidget {
  const TaskCategoriesListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksCubit, TasksState>(
      builder: (context, state) {
        String selectedCategory = state.selectedCategory;
        return SizedBox(
          height: 40.sp,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              TaskCategoryItem(
                text: AppStrings.all,
                isSelected: selectedCategory == AppStrings.allCategory,
                onTap: () => context.read<TasksCubit>().selectCategory(AppStrings.allCategory),
              ),
              SizedBox(width: 8.w),
              TaskCategoryItem(
                text: AppStrings.waiting,
                isSelected: selectedCategory == AppStrings.waitingCategory,
                onTap: () => context.read<TasksCubit>().selectCategory(AppStrings.waitingCategory),
              ),
              SizedBox(width: 8.w),
              TaskCategoryItem(
                text: AppStrings.inProgress,
                isSelected: selectedCategory == AppStrings.inProgressCategory,
                onTap: () =>
                    context.read<TasksCubit>().selectCategory(AppStrings.inProgressCategory),
              ),
              SizedBox(width: 8.w),
              TaskCategoryItem(
                text: AppStrings.finishedCategory,
                isSelected: selectedCategory == AppStrings.finishedCategory,
                onTap: () => context.read<TasksCubit>().selectCategory(AppStrings.finishedCategory),
              ),
            ],
          ),
        );
      },
    );
  }
}
