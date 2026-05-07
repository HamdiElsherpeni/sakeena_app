import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum ExamStatus { safe, moderate, danger }

class ExamStatusBadge extends StatelessWidget {
  const ExamStatusBadge({super.key, required this.status});

  final ExamStatus status;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: _borderColor, width: 1.2.w),
      ),
      child: Text(
        _label,
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          color: _textColor,
          fontFamily: 'Rubik',
        ),
      ),
    );
  }

  String get _label {
    switch (status) {
      case ExamStatus.safe:
        return 'آمن';
      case ExamStatus.moderate:
        return 'متابعة';
      case ExamStatus.danger:
        return 'خطير';
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
        return const Color(0xFF4CAF50);
      case ExamStatus.moderate:
        return const Color(0xFFFFB300);
      case ExamStatus.danger:
        return const Color(0xFFC72063);
    }
  }

  Color get _textColor {
    switch (status) {
      case ExamStatus.safe:
        return const Color(0xFF2E7D32);
      case ExamStatus.moderate:
        return const Color(0xFFF57F17);
      case ExamStatus.danger:
        return const Color(0xFFC72063);
    }
  }
}
