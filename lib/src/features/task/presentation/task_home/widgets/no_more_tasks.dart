import 'package:flutter/material.dart';

class NoMoreTasks extends StatelessWidget {
  const NoMoreTasks({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Text("No more tasks."),
      ),
    );
  }
}
