import 'package:flutter/material.dart';

class ToastConfig {
  static void showToast(BuildContext context, String message, bool isError) {
    // Dismiss any existing snackbars
    ScaffoldMessenger.of(context).clearSnackBars();

    final snackBar = SnackBar(
      content: Text(
        message,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
      backgroundColor: isError ? Colors.red.shade800 : Colors.green.shade800,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      duration: const Duration(seconds: 3),
      action: SnackBarAction(
        label: 'Dismiss',
        textColor: Colors.white,
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  // Convenience methods for success and error
  static void showSuccess(BuildContext context, String message) {
    showToast(context, message, false);
  }

  static void showError(BuildContext context, String message) {
    showToast(context, message, true);
  }
}

// Extension method for more convenient usage
extension ToastExtension on BuildContext {
  void showToast(String message, bool isError) {
    ToastConfig.showToast(this, message, isError);
  }

  void showSuccessToast(String message) {
    ToastConfig.showSuccess(this, message);
  }

  void showErrorToast(String message) {
    ToastConfig.showError(this, message);
  }
}
