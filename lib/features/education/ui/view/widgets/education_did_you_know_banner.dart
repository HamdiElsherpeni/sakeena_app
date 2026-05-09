import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakeena_app/core/resources/app_colors.dart';

class EducationDidYouKnowBanner extends StatelessWidget {
  const EducationDidYouKnowBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.07),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.2),
          width: 1.2.w,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'هل تعلمين؟',
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                  fontFamily: 'Rubik',
                ),
              ),
              SizedBox(width: 6.w),
              Icon(
                Icons.lightbulb_outline_rounded,
                color: AppColors.primary,
                size: 20.sp,
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            'الاكتشاف المبكر يزيد من فرص العلاج الناجح بنسبة تصل إلى 95٪. الفحص الذاتي المنتظم والفحوصات الطبية الدورية هي مفتاح الوقاية.',
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 13.sp,
              color: AppColors.textDark,
              fontFamily: 'Rubik',
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
