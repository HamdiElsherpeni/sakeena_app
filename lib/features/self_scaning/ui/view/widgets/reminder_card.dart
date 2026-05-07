import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakeena_app/core/resources/app_colors.dart';
import 'package:sakeena_app/core/widgets/coustem_eleveted_butten.dart';

class ReminderCard extends StatelessWidget {
  final String reminderText;
  final String callToActionLabel;
  final VoidCallback? onCallToAction;

  const ReminderCard({
    super.key,
    required this.reminderText,
    required this.callToActionLabel,
    this.onCallToAction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.skipBg.withOpacity(0.35),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.skipBg, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            textDirection: TextDirection.rtl,
            children: [
              Icon(
                Icons.info_outline_rounded,
                color: AppColors.primary,
                size: 18.r,
              ),
              SizedBox(width: 6.w),
              Text(
                'تذكير مهم',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Text(
            reminderText,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 13.sp,
              height: 1.7,
              color: AppColors.skipText,
            ),
          ),
          SizedBox(height: 14.h),
          CoustemElevetedBoutten(
            text: callToActionLabel,
            backgroundcolor: AppColors.primary,
            onPressed: onCallToAction,
          ),
        ],
      ),
    );
  }
}
