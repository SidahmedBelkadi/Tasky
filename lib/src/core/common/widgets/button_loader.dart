import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonCircularProgressIndicator extends StatelessWidget {
  const ButtonCircularProgressIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator.adaptive(
      backgroundColor: Colors.white,
      strokeWidth: 6.sp,
    );
  }
}
