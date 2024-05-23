import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/resources/app_icons.dart';

class CustomTasksAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomTasksAppBar({
    super.key,
    this.onUserIconPressed,
    this.onLogoutPressed,
    this.actions,
    this.showLeading = false,
    this.isLogo = false,
    required this.title,
  });

  final void Function()? onUserIconPressed;
  final void Function()? onLogoutPressed;
  final List<Widget>? actions;
  final bool showLeading;
  final bool isLogo;
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(
        title,
        style: isLogo
            ? Theme.of(context).textTheme.headlineMedium
            : Theme.of(context).textTheme.headlineSmall,
      ),
      leading: showLeading
          ? GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Image.asset(
                AppIcons.arrowLeft,
                height: 24.h,
                width: 24.w,
              ),
            )
          : null,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60.h);
}
