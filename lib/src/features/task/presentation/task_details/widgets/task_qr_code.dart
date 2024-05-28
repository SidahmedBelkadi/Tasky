import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class TaskQrCode extends StatelessWidget {
  const TaskQrCode({
    super.key,
    required this.data,
  });

  final String data;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 320.h,
        width: 320.w,
        padding: EdgeInsets.all(12.sp),
        child: PrettyQrView.data(
          data: data,
        ),
      ),
    );
  }
}
