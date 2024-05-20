import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';

class TaskItemDescription extends StatelessWidget {
  const TaskItemDescription({
    super.key,
    required this.desc,
  });

  final String desc;

  @override
  Widget build(BuildContext context) {
    return Text(
      desc,
      style:
          Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColors.categoryTextColorGrey),
      overflow: TextOverflow.ellipsis,
    );
  }
}
