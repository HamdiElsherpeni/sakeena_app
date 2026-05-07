import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'exam_status_badge.dart';

class ExamRiskIndicator extends StatelessWidget {
  const ExamRiskIndicator({
    super.key,
    required this.status,
    required this.label,
  });

  final ExamStatus status;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            color: _dotColor,
            fontWeight: FontWeight.w500,
            fontFamily: 'Rubik',
          ),
        ),
        SizedBox(width: 6.w),
        Container(
          width: 8.w,
          height: 8.w,
          decoration: BoxDecoration(color: _dotColor, shape: BoxShape.circle),
        ),
      ],
    );
  }

  Color get _dotColor {
    switch (status) {
      case ExamStatus.safe:
        return const Color(0xFF4CAF50);
      case ExamStatus.moderate:
        return const Color(0xFFFFB300);
      case ExamStatus.danger:
        return const Color(0xFFC72063);
    }
  }
}
