import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum RiskLevel { low, medium, high }

class AssessmentRiskGauge extends StatelessWidget {
  final RiskLevel riskLevel;

  const AssessmentRiskGauge({super.key, required this.riskLevel});

  double get _indicatorPosition {
    switch (riskLevel) {
      case RiskLevel.low:
        return 0.12;
      case RiskLevel.medium:
        return 0.5;
      case RiskLevel.high:
        return 0.88;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            final indicatorX = width * _indicatorPosition;
            return SizedBox(
              height: 28.h,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // gradient bar
                  Positioned(
                    top: 14.h,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 8.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.r),
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF4CAF50),
                            Color(0xFFFFC107),
                            Color(0xFFF44336),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // indicator circle
                  Positioned(
                    top: 6.h,
                    left: indicatorX - 11.r,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                      width: 22.r,
                      height: 22.r,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(
                          color: _indicatorColor,
                          width: 2.5.w,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: _indicatorColor.withOpacity(0.3),
                            blurRadius: 6,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        SizedBox(height: 6.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'منخفض',
              style: TextStyle(
                fontSize: 11.sp,
                color: const Color(0xFF4CAF50),
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              'متوسط',
              style: TextStyle(
                fontSize: 11.sp,
                color: const Color(0xFFFFC107),
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              'عالي',
              style: TextStyle(
                fontSize: 11.sp,
                color: const Color(0xFFF44336),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Color get _indicatorColor {
    switch (riskLevel) {
      case RiskLevel.low:
        return const Color(0xFF4CAF50);
      case RiskLevel.medium:
        return const Color(0xFFFFC107);
      case RiskLevel.high:
        return const Color(0xFFF44336);
    }
  }
}
