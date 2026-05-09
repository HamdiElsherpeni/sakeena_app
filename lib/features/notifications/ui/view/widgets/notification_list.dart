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
        if (state is NotificationLoading) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        }

        if (state is NotificationFailure) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.error_outline_rounded,
                  size: 48.sp,
                  color: AppColors.primary,
                ),
                SizedBox(height: 12.h),
                Text(
                  state.message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.textDark,
                    fontFamily: 'Rubik',
                  ),
                ),
                SizedBox(height: 16.h),
                TextButton(
                  onPressed: () =>
                      context.read<NotificationCubit>().loadNotifications(),
                  child: Text(
                    'إعادة المحاولة',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.primary,
                      fontFamily: 'Rubik',
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        if (state is NotificationSuccess) {
          if (state.notifications.isEmpty) {
            return const NotificationEmptyState();
          }

          return RefreshIndicator(
            color: AppColors.primary,
            onRefresh: () =>
                context.read<NotificationCubit>().loadNotifications(),
            child: Column(
              children: [
                // زرار قراءة الكل
                if (state.notifications.any((n) => !n.isRead))
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 8.h,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () =>
                            context.read<NotificationCubit>().markAllAsRead(),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 6.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.selectedBg,
                            borderRadius: BorderRadius.circular(20.r),
                            border: Border.all(
                              color: AppColors.border,
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
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                // القائمة
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.only(top: 8.h, bottom: 20.h),
                    itemCount: state.notifications.length,
                    itemBuilder: (context, index) {
                      final n = state.notifications[index];
                      return NotificationCard(
                        notification: n,
                        onTap: n.isRead
                            ? null
                            : () => context
                                  .read<NotificationCubit>()
                                  .markAsRead(n.id),
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
