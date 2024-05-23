import 'package:flutter/material.dart';

import '../../utils/helpers/media_query_values.dart';
import '../../utils/resources/app_images.dart';

class FemaleHeaderImageBackground extends StatelessWidget {
  const FemaleHeaderImageBackground({
    super.key,
    this.height,
    this.fit = BoxFit.cover,
  });
  final double? height;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    if (height != null) {
      return SizedBox(
        height: height,
        width: context.width,
        child: Image.asset(
          AppImages.authBackground,
          width: context.width,
          fit: fit,
        ),
      );
    }
    return Expanded(
      child: Image.asset(
        AppImages.authBackground,
        width: context.width,
        fit: fit,
      ),
    );
  }
}
