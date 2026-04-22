import 'package:flutter/material.dart';

class SnackBarHelper {
  SnackBarHelper._(); // يمنع إنشاء instance

  static void showSuccess(BuildContext context, {required String message}) {
    _show(
      context,
      message: message,
      backgroundColor: Colors.green,
      icon: Icons.check_circle,
    );
  }

  static void showError(BuildContext context, {required String message}) {
    _show(
      context,
      message: message,
      backgroundColor: Colors.red,
      icon: Icons.error,
    );
  }

  static void showInfo(BuildContext context, {required String message}) {
    _show(
      context,
      message: message,
      backgroundColor: Colors.blue,
      icon: Icons.info,
    );
  }

  static void _show(
    BuildContext context, {
    required String message,
    required Color backgroundColor,
    required IconData icon,
  }) {
    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(12),
        content: Row(
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 10),
            Expanded(
              child: Text(message, style: const TextStyle(color: Colors.white)),
            ),
          ],
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
