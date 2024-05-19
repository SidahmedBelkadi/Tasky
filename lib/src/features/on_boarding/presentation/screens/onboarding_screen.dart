import 'package:flutter/material.dart';
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

              const SizedBox(height: 20.0),

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
              const SizedBox(height: 64.0),
            ],
          ),
        ),
      ),
    );
  }
}
