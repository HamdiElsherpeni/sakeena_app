import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SnackBarHelper {
  SnackBarHelper._();

  // ─── بـ context (للاستخدام العادي) ──────────────────────────────────────

  static void showSuccess(BuildContext context, {required String message}) {
    _showWithMessenger(
      ScaffoldMessenger.of(context),
      message: message,
      backgroundColor: Colors.green,
      icon: Icons.check_circle,
    );
  }

  static void showError(BuildContext context, {required String message}) {
    _showWithMessenger(
      ScaffoldMessenger.of(context),
      message: message,
      backgroundColor: Colors.red,
      icon: Icons.error,
    );
  }

  static void showInfo(BuildContext context, {required String message}) {
    _showWithMessenger(
      ScaffoldMessenger.of(context),
      message: message,
      backgroundColor: Colors.blue,
      icon: Icons.info,
    );
  }

  // ─── بـ ScaffoldMessengerState (بعد async gaps) ───────────────────────
  // استخدامه:
  //   final messenger = ScaffoldMessenger.of(context); // قبل الـ await
  //   await someAsyncCall();
  //   SnackBarHelper.showErrorWithMessenger(messenger, message: '...');

  static void showSuccessWithMessenger(
    ScaffoldMessengerState messenger, {
    required String message,
  }) => _showWithMessenger(
    messenger,
    message: message,
    backgroundColor: Colors.green,
    icon: Icons.check_circle,
  );

  static void showErrorWithMessenger(
    ScaffoldMessengerState messenger, {
    required String message,
  }) => _showWithMessenger(
    messenger,
    message: message,
    backgroundColor: Colors.red,
    icon: Icons.error,
  );

  static void showInfoWithMessenger(
    ScaffoldMessengerState messenger, {
    required String message,
  }) => _showWithMessenger(
    messenger,
    message: message,
    backgroundColor: Colors.blue,
    icon: Icons.info,
  );

  // ─── Private ─────────────────────────────────────────────────────────────

  static void _showWithMessenger(
    ScaffoldMessengerState messenger, {
    required String message,
    required Color backgroundColor,
    required IconData icon,
  }) {
    messenger.clearSnackBars();
    messenger.showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        margin: EdgeInsets.all(12.w),
        content: Row(
          children: [
            Icon(icon, color: Colors.white),
            SizedBox(width: 10.w),
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
