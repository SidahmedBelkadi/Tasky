import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/common/widgets/app_elevated_button.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/media_query_values.dart';
import '../widgets/header_image.dart';
import '../widgets/header_texts.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: context.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// Header Image Background
              const OnBoardingHeaderImage(),

              SizedBox(height: 20.0.h),

              /// Header Title & SubTitle
              const OnBoardingHeaderTexts(),

              /// Button
              AppElevatedButton(
                isIconVisible: true,
                onPressed: () {},
                child: Text(
                  AppStrings.letsStart,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: Colors.white,
                      ),
                ),
              ),
              SizedBox(height: 64.0.h),
            ],
          ),
        ),
      ),
    );
  }
}
