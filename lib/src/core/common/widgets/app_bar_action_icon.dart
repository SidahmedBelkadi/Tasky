import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBarActionIcon extends StatelessWidget {
  const AppBarActionIcon({
    super.key,
    this.onTap,
    required this.asset,
    this.height = 24,
    this.width = 24,
  });

  final void Function()? onTap;
  final String asset;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Image.asset(
        asset,
        height: height.h,
        width: width.w,
      ),
    );
  }
}
