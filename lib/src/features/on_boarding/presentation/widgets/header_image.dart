import 'package:flutter/material.dart';

import '../../../../core/utils/app_images.dart';
import '../../../../core/utils/media_query_values.dart';

class OnBoardingHeaderImage extends StatelessWidget {
  const OnBoardingHeaderImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Image.asset(
        AppImages.authBackground,
        width: context.width,
        fit: BoxFit.cover,
      ),
    );
  }
}
