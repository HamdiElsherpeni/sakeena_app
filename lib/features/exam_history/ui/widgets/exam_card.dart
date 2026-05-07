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
    this.onDownload,
    this.onTap,
    this.isDownloadLoading = false,
  });

  final String date;
  final ExamStatus status;
  final String riskLabel;
  final VoidCallback? onDownload;
  final VoidCallback? onTap;
  final bool isDownloadLoading;

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
            _DownloadButton(
              onTap: isDownloadLoading ? null : onDownload,
              isLoading: isDownloadLoading,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
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
                    mainAxisAlignment: MainAxisAlignment.end,
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
            ExamStatusIcon(status: status),
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

class _DownloadButton extends StatelessWidget {
  const _DownloadButton({this.onTap, this.isLoading = false});

  final VoidCallback? onTap;
  final bool isLoading;

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
        child: isLoading
            ? Padding(
                padding: EdgeInsets.all(9.w),
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.primary,
                ),
              )
            : Icon(
                Icons.download_rounded,
                size: 18.sp,
                color: AppColors.primary,
              ),
      ),
    );
  }
}
