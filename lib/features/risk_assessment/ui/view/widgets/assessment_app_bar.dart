import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakeena_app/core/resources/app_colors.dart';
import 'package:sakeena_app/core/widgets/custom_circle_avatar.dart';

class AssessmentAppBar extends StatelessWidget {
  const AssessmentAppBar({
    super.key,
    required this.showResult,
    required this.currentStep,
    required this.onBack,
  });

  final bool showResult;
  final int currentStep;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final titles = ['الشخصية', 'الهرمونية', 'العائلية', 'الطبية'];

    /// ================= RESULT APPBAR =================
    if (showResult) {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.only(
          top: 12.h,
          right: 18.w,
          left: 18.w,
          bottom: 18.h,
        ),
        decoration: BoxDecoration(
          color: showResult ? AppColors.kprimaryColor : Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30.r),
            bottomRight: Radius.circular(30.r),
          ),
          boxShadow: showResult
              ? null
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(.04),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(onTap: onBack, child: CustomCircleAvatar()),

            Text(
              'نتيجة التقييم',
              style: TextStyle(
                fontSize: 26.sp,
                fontWeight: FontWeight.w800,
                color: const Color(0xff3A3A3A),
              ),
            ),

            SizedBox(width: 38.w),
          ],
        ),
      );
    }

    /// ================= NORMAL APPBAR =================
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: 12.h,
        right: 18.w,
        left: 18.w,
        bottom: 18.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30.r),
          bottomRight: Radius.circular(30.r),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          /// ================= TOP ROW =================
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(onTap: onBack, child: CustomCircleAvatar()),

              Column(
                children: [
                  Text(
                    'التقييم الصحي',
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w800,
                      color: AppColors.primary,
                    ),
                  ),

                  SizedBox(height: 4.h),

                  Text(
                    'الخطوة $currentStep من 4',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xffA6A6A6),
                    ),
                  ),
                ],
              ),

              SizedBox(width: 38.w),
            ],
          ),

          SizedBox(height: 20.h),

          /// ================= STEP INDICATOR =================
          Column(
            children: [
              /// الخطوط
              Row(
                children: List.generate(4, (index) {
                  final isActive = currentStep == index + 1;

                  return Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3.w),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        height: 5.h,
                        decoration: BoxDecoration(
                          color: isActive
                              ? AppColors.primary
                              : const Color(0xffE8C9D3),
                          borderRadius: BorderRadius.circular(100.r),
                        ),
                      ),
                    ),
                  );
                }),
              ),

              SizedBox(height: 10.h),

              /// النصوص
              Row(
                children: List.generate(4, (index) {
                  final isActive = currentStep == index + 1;

                  return Expanded(
                    child: Center(
                      child: Text(
                        titles[index],
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                          color: isActive
                              ? AppColors.primary
                              : const Color(0xffD1D1D1),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
