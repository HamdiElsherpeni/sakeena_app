import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakeena_app/core/resources/app_colors.dart';

class AssessmentStepIndicator extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final List<String> stepLabels;

  const AssessmentStepIndicator({
    super.key,
    required this.currentStep,
    required this.totalSteps,
    required this.stepLabels,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'الخطوة $currentStep من $totalSteps',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xff9A9A9A),
          ),
        ),

        SizedBox(height: 14.h),

        Row(
          children: List.generate(totalSteps, (index) {
            final stepNumber = index + 1;

            final isActive = stepNumber == currentStep;

            return Expanded(
              child: Column(
                children: [
                  Container(
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: isActive
                          ? AppColors.primary
                          : const Color(0xffE9E1DC),
                      borderRadius: BorderRadius.circular(100.r),
                    ),
                  ),

                  SizedBox(height: 8.h),

                  Text(
                    stepLabels[index],
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: isActive
                          ? AppColors.primary
                          : const Color(0xffC6C6C6),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ],
    );
  }
}
