import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakeena_app/core/resources/app_colors.dart';

class UploadCard extends StatelessWidget {
  final VoidCallback? onTap;
  final bool isLoading;

  const UploadCard({super.key, this.onTap, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 36.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 72.w,
              height: 72.h,
              decoration: BoxDecoration(
                color: AppColors.skipBg,
                shape: BoxShape.circle,
              ),
              child: isLoading
                  ? Padding(
                      padding: EdgeInsets.all(18.w),
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        color: AppColors.skipText,
                      ),
                    )
                  : Icon(
                      Icons.upload_rounded,
                      size: 34.sp,
                      color: AppColors.skipText,
                    ),
            ),
            SizedBox(height: 16.h),
            Text(
              'رفع صورة طبية',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
                fontFamily: 'Cairo',
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              'اختاري صورة من معرض الصور أو التقطي صورة جديدة',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13.sp,
                color: Colors.grey[500],
                fontFamily: 'Cairo',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
