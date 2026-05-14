import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakeena_app/core/resources/app_colors.dart';

class NotificationEmptyState extends StatelessWidget {
  const NotificationEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 90.r,
            height: 90.r,
            decoration: BoxDecoration(
              color: AppColors.selectedBg,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.notifications_none_rounded,
              size: 44.sp,
              color: AppColors.primary,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            'لا توجد إشعارات',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.textDark,
              fontFamily: 'Rubik',
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'ستظهر هنا إشعاراتك عند وصولها',
            style: TextStyle(
              fontSize: 13.sp,
              color: AppColors.textSecondary,
              fontFamily: 'Rubik',
            ),
          ),
        ],
      ),
    );
  }
}
