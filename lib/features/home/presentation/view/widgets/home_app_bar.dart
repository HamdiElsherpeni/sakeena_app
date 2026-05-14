import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sakeena_app/core/resources/app_assets.dart';
import 'package:sakeena_app/core/resources/app_colors.dart';
import 'package:sakeena_app/core/utils/app_router.dart';
import 'package:sakeena_app/features/account/logic/cubit/account_cubit.dart';
import 'package:sakeena_app/features/account/logic/cubit/account_state.dart';
import 'package:sakeena_app/features/notifications/logic/cubit/notification_cubit.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  Widget _skeleton() {
    return Container(
      width: 120.w,
      height: 18.h,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(6.r),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Settings
        Container(
          width: 38.w,
          height: 38.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Icon(Icons.tune, color: AppColors.primary, size: 20),
        ),

        // Name
        BlocBuilder<AccountCubit, AccountState>(
          builder: (context, state) {
            final cubit = context.read<AccountCubit>();
            final user = cubit.user;

            final isLoading = state is AccountLoading || user == null;

            return Row(
              children: [
                Image.asset(AppAssets.logo, width: 35.w, height: 35.h),
                SizedBox(width: 6.w),
                isLoading
                    ? _skeleton()
                    : Text(
                        'أهلا ${user.firstName} ${user.lastName}',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF2D2D2D),
                        ),
                      ),
              ],
            );
          },
        ),

        // Notifications
        BlocBuilder<NotificationCubit, NotificationState>(
          builder: (context, state) {
            int unreadCount = 0;

            if (state is NotificationSuccess) {
              unreadCount = state.notifications.where((e) => !e.isRead).length;
            }

            return GestureDetector(
              onTap: () {
                context.push(AppRouter.kNotificationView);
              },
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Icon(
                    Icons.notifications_none,
                    size: 28,
                    color: const Color(0xFF2D2D2D),
                  ),

                  if (unreadCount > 0)
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        width: 10.w,
                        height: 10.w,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 1),
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
