import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/helpers/media_query_values.dart';
import '../../utils/resources/app_images.dart';

class FemaleHeaderImageBackground extends StatelessWidget {
  const FemaleHeaderImageBackground({
    super.key,
    this.height,
    this.fit = BoxFit.cover,
    this.image = AppImages.authBackgroundSvg,
  });
  final double? height;
  final BoxFit fit;
  final String image;

  @override
  Widget build(BuildContext context) {
    if (height != null) {
      return SizedBox(
        height: height,
        width: context.width,
        child: SvgPicture.asset(
          image,
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
