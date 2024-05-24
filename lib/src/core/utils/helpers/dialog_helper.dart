import 'package:flutter/material.dart';
import '../resources/app_colors.dart';

abstract class AppDialog {
  static void showCustomAppDialog({
    required String title,
    String content = "This action cannot be undone.",
    required BuildContext context,
    void Function()? onPressed,
    isLoading = false,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            isLoading
                ? const CircularProgressIndicator.adaptive()
                : TextButton(
                    onPressed: onPressed,
                    child: const Text("Logout", style: TextStyle(color: AppColors.primary)),
                  ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("Cancel"),
            ),
          ],
        );
      },
    );
  }
}
