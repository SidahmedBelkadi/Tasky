import 'package:flutter/material.dart';

class NoTasksFound extends StatelessWidget {
  const NoTasksFound({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'No tasks found.',
        style: Theme.of(context).textTheme.headlineSmall,
        textAlign: TextAlign.center,
      ),
    );
  }
}
