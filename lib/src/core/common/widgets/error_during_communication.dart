import 'package:flutter/material.dart';
import 'package:tasky/src/core/utils/resources/app_messages.dart';

class ErrorDuringCommunication extends StatelessWidget {
  const ErrorDuringCommunication({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        AppMessages.errorDuringCommunication,
        style: Theme.of(context).textTheme.headlineSmall,
        textAlign: TextAlign.center,
      ),
    );
  }
}
