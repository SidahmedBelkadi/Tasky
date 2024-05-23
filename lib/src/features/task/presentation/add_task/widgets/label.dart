import 'package:flutter/material.dart';

import '../../../../../core/utils/resources/app_colors.dart';

class AddTaskLabel extends StatelessWidget {
  const AddTaskLabel({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.labelSmall!.copyWith(
            color: AppColors.secondaryText,
          ),
    );
  }
}
