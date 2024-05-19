import 'package:flutter/material.dart';
import '../../utils/app_icons.dart';
import '../../utils/media_query_values.dart';

class AppElevatedButton extends StatelessWidget {
  const AppElevatedButton({
    super.key,
    this.isIconVisible = false,
    required this.child,
    this.icon = AppIcons.arrowLeft,
    this.onPressed,
  });

  final bool isIconVisible;
  final Widget child;
  final String icon;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            child,
            const SizedBox(width: 10.0),
            isIconVisible ? Image.asset(icon, height: 24, width: 24) : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
