import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common/widgets/app_bar.dart';
import '../../../../core/utils/resources/app_strings.dart';
import 'widgets/form.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildTaskDetailAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8.h),

                /// Task Detail Form
                const AddTaskForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  CustomTasksAppBar buildTaskDetailAppBar() {
    return const CustomTasksAppBar(
      title: AppStrings.addNewTask,
      showLeading: true,
    );
  }
}
