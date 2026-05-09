import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakeena_app/core/resources/app_colors.dart';
import 'package:sakeena_app/features/notifications/data/models/notification_model.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({super.key, required this.notification, this.onTap});

  final NotificationModel notification;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: notification.isRead
              ? AppColors.white
              : const Color(0xFFFFF0F5),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: notification.isRead
                ? AppColors.border
                : AppColors.primary.withOpacity(0.25),
            width: 1.2.w,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // المحتوى
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // وقت + نقطة غير مقروء
                      Row(
                        children: [
                          if (!notification.isRead)
                            Container(
                              width: 7.w,
                              height: 7.w,
                              margin: EdgeInsets.only(left: 6.w),
                              decoration: const BoxDecoration(
                                color: AppColors.primary,
                                shape: BoxShape.circle,
                              ),
                            ),
                          Text(
                            notification.formattedTime,
                            style: TextStyle(
                              fontSize: 11.sp,
                              color: AppColors.textSecondary,
                              fontFamily: 'Rubik',
                            ),
                          ),
                        ],
                      ),
                      // العنوان
                      Text(
                        notification.title,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textDark,
                          fontFamily: 'Rubik',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    notification.body,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.textSecondary,
                      fontFamily: 'Rubik',
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 12.w),
            // الأيقونة
            _NotificationIcon(type: notification.type),
          ],
        ),
      ),
    );
  }
}

class _NotificationIcon extends StatelessWidget {
  const _NotificationIcon({required this.type});

  final NotificationType type;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44.w,
      height: 44.w,
      decoration: BoxDecoration(
        color: _bgColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: _borderColor, width: 1.2.w),
      ),
      child: Icon(_icon, size: 22.sp, color: _iconColor),
    );
  }

  IconData get _icon {
    switch (type) {
      case NotificationType.scanResult:
        return Icons.check_circle_outline_rounded;
      case NotificationType.reminder:
        return Icons.access_time_rounded;
      case NotificationType.general:
        return Icons.notifications_outlined;
    }
  }

  Color get _bgColor {
    switch (type) {
      case NotificationType.scanResult:
        return const Color(0xFFE8F5E9);
      case NotificationType.reminder:
        return const Color(0xFFFFF8E1);
      case NotificationType.general:
        return const Color(0xFFFCF4F7);
    }
  }

  Color get _borderColor {
    switch (type) {
      case NotificationType.scanResult:
        return const Color(0xFF4CAF50).withOpacity(0.3);
      case NotificationType.reminder:
        return const Color(0xFFFFB300).withOpacity(0.4);
      case NotificationType.general:
        return const Color(0xFFC72063).withOpacity(0.2);
    }
  }

  Color get _iconColor {
    switch (type) {
      case NotificationType.scanResult:
        return const Color(0xFF4CAF50);
      case NotificationType.reminder:
        return const Color(0xFFFFB300);
      case NotificationType.general:
        return AppColors.primary;
    }
  }
}
