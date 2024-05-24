import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/common/widgets/button_loader.dart';
import '../../../../core/utils/helpers/dialog_helper.dart';
import '../../../../core/utils/helpers/toast_helper.dart';
import '../../../auth/presentation/sign_out/cubit/sign_out_cubit.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/common/widgets/app_bar.dart';
import '../../../../core/common/widgets/app_bar_action_icon.dart';
import '../../../../core/utils/resources/app_icons.dart';
import '../../../../core/utils/resources/app_strings.dart';
import 'widgets/categories_listview.dart';
import 'widgets/floating_action_buttons.dart';
import 'widgets/tasks_listview.dart';
import 'widgets/title.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildTasksHomeAppBar(context),
      floatingActionButton: const CustomTasksScreenFloatingActionButtons(),
      body: Padding(
        padding: EdgeInsets.all(22.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Tasks Title
            const TasksHomeTitle(),

            SizedBox(height: 8.h),

            /// Categories ListView
            const TaskCategoriesListView(),

            SizedBox(height: 32.h),

            /// Tasks ListView
            const Expanded(
              child: TasksListView(),
            ),
          ],
        ),
      ),
    );
  }

  /// Function That Build The appBar
  CustomTasksAppBar buildTasksHomeAppBar(BuildContext context) {
    return CustomTasksAppBar(
      isLogo: true,
      title: AppStrings.tasky,
      actions: [
        AppBarActionIcon(
          asset: AppIcons.user,
          onTap: () {
            Navigator.of(context).pushNamed(Routes.profile);
          },
        ),
        SizedBox(width: 10.w),
        BlocConsumer<SignOutCubit, SignOutState>(
          listener: (context, state) {
            if (state is SignOutSuccessful) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                Routes.signIn,
                (route) => false,
              );
            } else if (state is SignOutUnSuccessful) {
              Navigator.of(context).pop();
              AppToasts.showErrorToast(message: state.message, context: context);
            }
          },
          builder: (context, state) {
            if (state is SignOutLoading) {
              Navigator.of(context).pop();
              return const ButtonCircularProgressIndicator(height: 20, width: 20);
            }
            return AppBarActionIcon(
              asset: AppIcons.logout,
              onTap: () {
                AppDialog.showCustomAppDialog(
                  title: AppStrings.doYouWantToLogout,
                  context: context,
                  onPressed: () => context.read<SignOutCubit>().signOut(),
                );
              },
            );
          },
        ),
        SizedBox(width: 10.w),
      ],
    );
  }
}
