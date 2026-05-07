import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakeena_app/core/resources/app_colors.dart';

class AssessmentActionButtons extends StatelessWidget {
  const AssessmentActionButtons({
    super.key,
    required this.currentStep,
    required this.stepComplete,
    required this.onBack,
    required this.onNext,
  });

  final int currentStep;
  final bool stepComplete;
  final VoidCallback onBack;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (currentStep > 1)
          Expanded(
            child: OutlinedButton(
              onPressed: onBack,
              style: OutlinedButton.styleFrom(
                minimumSize: Size(double.infinity, 56.h),
                backgroundColor: Colors.white,
                side: BorderSide(color: const Color(0xffD9B8C5), width: 1.w),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.r),
                ),
              ),
              child: Text(
                'السابق',
                style: TextStyle(
                  color: const Color(0xff7A7A7A),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),

        if (currentStep > 1) SizedBox(width: 12.w),

        Expanded(
          flex: 2,
          child: ElevatedButton(
            onPressed: stepComplete ? onNext : null,
            style: ElevatedButton.styleFrom(
              elevation: 0,
              minimumSize: Size(double.infinity, 56.h),
              backgroundColor: AppColors.primary,
              disabledBackgroundColor: const Color(0xffD7A7B9),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.r),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.chevron_left, color: Colors.white),
                Text(
                  currentStep < 4 ? 'التالي' : 'اظهار النتائج',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
