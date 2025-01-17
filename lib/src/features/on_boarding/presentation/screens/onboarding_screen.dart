import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/common/widgets/female_header_image.dart';
import '../../../../core/utils/helpers/launch_helper.dart';
import '../../../../core/utils/helpers/media_query_values.dart';
import '../../../../injection_container.dart' as di;
import '../widgets/button.dart';
import '../widgets/header_texts.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: context.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// Header Image Background
            const FemaleHeaderImageBackground(),

            SizedBox(height: 20.0.h),

            /// Header Title & SubTitle
            const OnBoardingHeaderTexts(),

            /// Button
            OnBoardingButton(
              onPressed: () {
                di.serviceLocator<LaunchHelper>().firstTime();
                Navigator.of(context).pushReplacementNamed(Routes.signIn);
              },
            ),
            SizedBox(height: 64.0.h),
          ],
        ),
      ),
    );
  }
}
