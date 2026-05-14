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
                : AppColors.primary.withOpacity(0.35),
            width: notification.isRead ? 1.w : 1.4.w,
          ),
          boxShadow: notification.isRead
              ? null
              : [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.07),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── المحتوى ───────────────────────────────────────────────
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // وقت + نقطة "جديد"
                      Row(
                        children: [
                          if (!notification.isRead) ...[
                            _PulseDot(),
                            SizedBox(width: 5.w),
                          ],
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
                      Flexible(
                        child: Text(
                          notification.title,
                          textAlign: TextAlign.right,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textDark,
                            fontFamily: 'Rubik',
                          ),
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
                  // ── شريط "اضغط للتحديد كمقروء" ───────────────────────
                  if (!notification.isRead) ...[
                    SizedBox(height: 8.h),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'اضغط لتحديدها كمقروءة',
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: AppColors.primary.withOpacity(0.7),
                          fontFamily: 'Rubik',
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),

            SizedBox(width: 12.w),

            // ── الأيقونة ──────────────────────────────────────────────
            _NotificationIcon(type: notification.type),
          ],
        ),
      ),
    );
  }
}

// ── نقطة نابضة للإشعار الجديد ─────────────────────────────────────────────────
class _PulseDot extends StatefulWidget {
  @override
  State<_PulseDot> createState() => _PulseDotState();
}

class _PulseDotState extends State<_PulseDot>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
    _anim = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _anim,
      child: Container(
        width: 8.r,
        height: 8.r,
        decoration: const BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

// ── أيقونة الإشعار ────────────────────────────────────────────────────────────
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
