import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/app_icons.dart';
import '../../utils/media_query_values.dart';

class AppElevatedButton extends StatelessWidget {
  const AppElevatedButton({
    super.key,
    this.isIconVisible = false,
    required this.child,
    this.icon = AppIcons.arrowRight,
    this.onPressed,
  });

  final bool isIconVisible;
  final Widget child;
  final String icon;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width,
      height: 64.h,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            child,
            SizedBox(width: 10.0.w),
            if (isIconVisible) Image.asset(icon, height: 24.h, width: 24.w),
          ],
        ),
      ),
    );
  }
}
