import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakeena_app/core/resources/app_colors.dart';
import 'exam_risk_indicator.dart';
import 'exam_status_badge.dart';
import 'exam_status_icon.dart';

class ExamCard extends StatelessWidget {
  const ExamCard({
    super.key,
    required this.date,
    required this.status,
    required this.riskLabel,
    this.onView,
    this.onTap,
  });

  final String date;
  final ExamStatus status;
  final String riskLabel;
  final VoidCallback? onView;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: _cardBorderColor, width: 1.2.w),
        ),
        child: Row(
          children: [
            ExamStatusIcon(status: status),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'تقرير الفحص',
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textDark,
                      fontFamily: 'Rubik',
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    date,
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: AppColors.textSecondary,
                      fontFamily: 'Rubik',
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ExamStatusBadge(status: status),
                      SizedBox(width: 10.w),
                      ExamRiskIndicator(status: status, label: riskLabel),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 12.w),
            _ViewButton(onTap: onView),
          ],
        ),
      ),
    );
  }

  Color get _cardBorderColor {
    switch (status) {
      case ExamStatus.safe:
        return const Color(0xFF4CAF50).withOpacity(0.3);
      case ExamStatus.moderate:
        return const Color(0xFFFFB300).withOpacity(0.4);
      case ExamStatus.danger:
        return const Color(0xFFC72063).withOpacity(0.3);
    }
  }
}

class _ViewButton extends StatelessWidget {
  const _ViewButton({this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36.w,
        height: 36.w,
        decoration: BoxDecoration(
          color: AppColors.kprimaryColor,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: AppColors.border, width: 1.w),
        ),
        child: Icon(
          Icons.remove_red_eye_outlined,
          size: 18.sp,
          color: AppColors.primary,
        ),
      ),
    );
  }
}
