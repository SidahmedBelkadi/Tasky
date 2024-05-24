import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

abstract class AppToasts {
  static void showSuccessToast({required String message, required BuildContext context}) {
    toastification.show(
      context: context,
      title: const Text('Yeaa!'),
      description: Text(
        message,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      autoCloseDuration: const Duration(seconds: 5),
      showProgressBar: false,
      type: ToastificationType.success,
      style: ToastificationStyle.minimal,
    );
  }

  static void showInfoToast({required String message, required BuildContext context}) {
    toastification.show(
      context: context,
      title: const Text('Yeaa!'),
      description: Text(
        message,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      autoCloseDuration: const Duration(seconds: 5),
      showProgressBar: false,
      type: ToastificationType.info,
      style: ToastificationStyle.flatColored,
      icon: const Icon(
        Icons.check_circle,
        color: Colors.blueAccent,
      ),
    );
  }

  static void showErrorToast({required String message, required BuildContext context}) {
    toastification.show(
      context: context,
      title: const Text('Oops!'),
      description: Text(
        message,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      autoCloseDuration: const Duration(seconds: 5),
      showProgressBar: false,
      type: ToastificationType.error,
      style: ToastificationStyle.minimal,
    );
  }
}
