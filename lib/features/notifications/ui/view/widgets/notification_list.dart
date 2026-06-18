import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakeena_app/core/resources/app_colors.dart';
import 'package:sakeena_app/features/notifications/logic/cubit/notification_cubit.dart';
import 'notification_card.dart';
import 'notification_empty_state.dart';

class NotificationList extends StatelessWidget {
  const NotificationList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationCubit, NotificationState>(
      builder: (context, state) {
        // ── Loading ───────────────────────────────────────────────────────
        if (state is NotificationLoading) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        }

        // ── Error ─────────────────────────────────────────────────────────
        if (state is NotificationFailure) {
          return Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 72.r,
                    height: 72.r,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFEBEE),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.wifi_off_rounded,
                      size: 34.sp,
                      color: const Color(0xFFC62828),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'تعذّر تحميل الإشعارات',
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textDark,
                      fontFamily: 'Rubik',
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    'تحقق من اتصالك بالإنترنت وحاول مرة أخرى',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.textSecondary,
                      fontFamily: 'Rubik',
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  GestureDetector(
                    onTap: () =>
                        context.read<NotificationCubit>().loadNotifications(),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w,
                        vertical: 12.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                      child: Text(
                        'إعادة المحاولة',
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontFamily: 'Rubik',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        // ── Success ───────────────────────────────────────────────────────
        if (state is NotificationSuccess) {
          // فلترة الغير مقروء بس
          final unread = state.notifications.where((n) => !n.isRead).toList();

          if (unread.isEmpty) {
            return const NotificationEmptyState();
          }

          return RefreshIndicator(
            color: AppColors.primary,
            onRefresh: () =>
                context.read<NotificationCubit>().loadNotifications(),
            child: Column(
              children: [
                // عداد الغير مقروء + زرار قراءة الكل
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 8.h,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () =>
                            context.read<NotificationCubit>().markAllAsRead(),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 7.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.selectedBg,
                            borderRadius: BorderRadius.circular(20.r),
                            border: Border.all(
                              color: AppColors.primary.withOpacity(0.3),
                              width: 1.w,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.done_all_rounded,
                                size: 14.sp,
                                color: AppColors.primary,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                'قراءة الكل',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontFamily: 'Rubik',
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Text(
                          '${unread.length} جديد',
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: Colors.white,
                            fontFamily: 'Rubik',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.only(top: 4.h, bottom: 20.h),
                    itemCount: unread.length,
                    itemBuilder: (context, index) {
                      final n = unread[index];
                      return NotificationCard(
                        notification: n,
                        onTap: () =>
                            context.read<NotificationCubit>().markAsRead(n.id),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}