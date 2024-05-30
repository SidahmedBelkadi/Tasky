import 'package:flutter/material.dart';
import 'package:tasky/src/core/utils/resources/app_strings.dart';

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
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("Cancel"),
            ),
            isLoading
                ? const CircularProgressIndicator.adaptive()
                : TextButton(
                    onPressed: onPressed,
                    child: const Text(
                      "Logout",
                      style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),
                    ),
                  ),
          ],
        );
      },
    );
  }

  static Future<bool?> showExitConfirmationDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(AppStrings.exitApp),
          content: const Text(AppStrings.doYouWantToExitApp),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text(AppStrings.no),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text(
                AppStrings.yes,
                style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }
}
