import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sakeena_app/core/resources/app_assets.dart';
import 'package:sakeena_app/core/resources/app_colors.dart';
import 'package:sakeena_app/core/utils/app_router.dart';
import 'package:sakeena_app/features/account/logic/cubit/account_cubit.dart';
import 'package:sakeena_app/features/account/logic/cubit/account_state.dart';

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
    return BlocBuilder<AccountCubit, AccountState>(
      builder: (context, state) {
        final cubit = context.read<AccountCubit>();
        final user = cubit.user;

        final isLoading = state is AccountLoading || user == null;

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Settings icon
            Container(
              width: 38.w,
              height: 38.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(Icons.tune, color: AppColors.primary, size: 20),
            ),

            // Name or Skeleton
            Row(
              children: [
                Image.asset(AppAssets.logo, width: 35.w, height: 35.h),
                isLoading
                    ? _skeleton()
                    : Text(
                        'أهلا ${user.firstName} ${user.lastName}',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2D2D2D),
                        ),
                      ),
                SizedBox(width: 8.w),
              ],
            ),

            // Bell icon
            GestureDetector(
              onTap: () {
                context.push(AppRouter.kNotificationView);
              },
              child: Stack(
                children: [
                  Icon(
                    Icons.notifications_none,
                    size: 28,
                    color: Color(0xFF2D2D2D),
                  ),
                  Positioned(
                    top: 0.h,
                    right: 0.w,
                    child: Container(
                      width: 8.w,
                      height: 8.h,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
