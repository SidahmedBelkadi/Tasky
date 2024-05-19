import 'package:flutter/material.dart';
import '../../../../core/utils/app_strings.dart';

class OnBoardingHeaderTexts extends StatelessWidget {
  const OnBoardingHeaderTexts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 64.0),
      child: Column(
        children: [
          Text(
            AppStrings.onBoardingTitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 12.0),
          Text(
            AppStrings.onBoardingSubTitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 32.0),
        ],
      ),
    );
  }
}
