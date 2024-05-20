import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/common/widgets/app_bar_action_icon.dart';
import '../../../../../core/utils/app_icons.dart';
import '../../../../../core/utils/app_strings.dart';

class TasksHomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TasksHomeAppBar({
    super.key,
    this.onUserIconPressed,
    this.onLogoutPressed,
  });

  final void Function()? onUserIconPressed;
  final void Function()? onLogoutPressed;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        AppStrings.tasky,
        style: Theme.of(context).textTheme.headlineMedium,
      ),
      actions: [
        AppBarActionIcon(
          asset: AppIcons.user,
          onTap: () {},
        ),
        SizedBox(width: 10.w),
        AppBarActionIcon(
          asset: AppIcons.logout,
          onTap: () {},
        ),
        SizedBox(width: 10.w),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60.h);
}
