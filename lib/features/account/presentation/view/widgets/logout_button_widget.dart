import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sakeena_app/core/di/service_locator.dart';
import 'package:sakeena_app/core/utils/app_router.dart';
import 'package:sakeena_app/features/auth/logic/auth_cubit.dart';

class LogoutButtonWidget extends StatelessWidget {
  const LogoutButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: () => _showLogoutDialog(context),
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFFB5456A),
          side: BorderSide(color: const Color(0xFFB5456A), width: 1.5.w),
          padding: EdgeInsets.symmetric(vertical: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.r),
          ),
        ),
        icon: const Icon(Icons.logout, size: 18),
        label: Text(
          'تسجيل الخروج',
          style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('تسجيل الخروج'),
          content: const Text('هل أنت متأكد أنك تريد تسجيل الخروج؟'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('إلغاء'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFB5456A),
              ),
              onPressed: () async {
                Navigator.pop(dialogContext);
                await getIt<AuthCubit>().logout();
                if (context.mounted) {
                  context.go(AppRouter.kwellComView);
                }
              },
              child: const Text('تأكيد'),
            ),
          ],
        );
      },
    );
  }
}
