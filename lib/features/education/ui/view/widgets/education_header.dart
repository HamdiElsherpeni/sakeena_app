import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sakeena_app/core/resources/app_colors.dart';
import 'package:sakeena_app/core/utils/app_router.dart';

class EducationHeader extends StatelessWidget {
  const EducationHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15.r),
          bottomRight: Radius.circular(15.r),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // العنوان والـ subtitle
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'التعليم والتوعية',
                style: TextStyle(
                  fontSize: 25.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                  fontFamily: 'Rubik',
                ),
              ),
              Text(
                'معلومات مهمة لصحتك',
                style: TextStyle(
                  fontSize: 15.sp,
                  color: AppColors.textSecondary,
                  fontFamily: 'Rubik',
                ),
              ),
            ],
          ),

          // placeholder للتمركز
          SizedBox(width: 36.w),
        ],
      ),
    );
  }
}
