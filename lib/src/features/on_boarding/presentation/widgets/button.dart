import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/common/widgets/app_elevated_button.dart';
import '../../../../core/utils/app_strings.dart';

class OnBoardingButton extends StatelessWidget {
  const OnBoardingButton({
    super.key,
    this.onPressed,
  });
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.0.sp),
      child: AppElevatedButton(
        isIconVisible: true,
        onPressed: onPressed,
        child: Text(
          AppStrings.letsStart,
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: Colors.white,
              ),
        ),
      ),
    );
  }
}
