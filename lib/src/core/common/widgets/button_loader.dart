import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonCircularProgressIndicator extends StatelessWidget {
  const ButtonCircularProgressIndicator({
    super.key,
    this.height,
    this.width,
  });

  final int? height;
  final int? width;

  @override
  Widget build(BuildContext context) {
    if (height != null && width != null) {
      return SizedBox(
        height: height!.h,
        width: width!.w,
        child: CircularProgressIndicator.adaptive(
          backgroundColor: Colors.white,
          strokeWidth: 6.sp,
        ),
      );
    }
    return CircularProgressIndicator.adaptive(
      backgroundColor: Colors.white,
      strokeWidth: 6.sp,
    );
  }
}
