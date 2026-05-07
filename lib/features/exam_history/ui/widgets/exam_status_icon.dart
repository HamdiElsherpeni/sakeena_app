import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'exam_status_badge.dart';

class ExamStatusIcon extends StatelessWidget {
  const ExamStatusIcon({super.key, required this.status});

  final ExamStatus status;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44.w,
      height: 44.w,
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: _borderColor, width: 1.2.w),
      ),
      child: Icon(_icon, size: 22.sp, color: _iconColor),
    );
  }

  IconData get _icon {
    switch (status) {
      case ExamStatus.safe:
        return Icons.check_circle_outline_rounded;
      case ExamStatus.moderate:
        return Icons.warning_amber_rounded;
      case ExamStatus.danger:
        return Icons.warning_amber_rounded;
    }
  }

  Color get _backgroundColor {
    switch (status) {
      case ExamStatus.safe:
        return const Color(0xFFE8F5E9);
      case ExamStatus.moderate:
        return const Color(0xFFFFF8E1);
      case ExamStatus.danger:
        return const Color(0xFFFFEBEE);
    }
  }

  Color get _borderColor {
    switch (status) {
      case ExamStatus.safe:
        return const Color(0xFF4CAF50).withOpacity(0.3);
      case ExamStatus.moderate:
        return const Color(0xFFFFB300).withOpacity(0.4);
      case ExamStatus.danger:
        return const Color(0xFFC72063).withOpacity(0.3);
    }
  }

  Color get _iconColor {
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
