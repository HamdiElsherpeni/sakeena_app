import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakeena_app/features/risk_assessment/ui/view/widgets/assessment_risk_gauge.dart';

class RiskFactorRow extends StatelessWidget {
  final String label;
  final RiskLevel riskLevel;

  const RiskFactorRow({
    super.key,
    required this.label,
    required this.riskLevel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: const Color(0xffECDEDE), width: 1.w),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _RiskBadge(riskLevel: riskLevel),
          Text(
            label,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xff2D1A1A),
            ),
          ),
        ],
      ),
    );
  }
}

class _RiskBadge extends StatelessWidget {
  final RiskLevel riskLevel;
  const _RiskBadge({required this.riskLevel});

  String get _label {
    switch (riskLevel) {
      case RiskLevel.low:
        return 'منخفض';
      case RiskLevel.medium:
        return 'متوسط';
      case RiskLevel.high:
        return 'عالي';
    }
  }

  Color get _bgColor {
    switch (riskLevel) {
      case RiskLevel.low:
        return const Color(0xFFE8F5E9);
      case RiskLevel.medium:
        return const Color(0xFFFFF8E1);
      case RiskLevel.high:
        return const Color(0xFFFFEBEE);
    }
  }

  Color get _textColor {
    switch (riskLevel) {
      case RiskLevel.low:
        return const Color(0xFF2E7D32);
      case RiskLevel.medium:
        return const Color(0xFFF57F17);
      case RiskLevel.high:
        return const Color(0xFFC62828);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: _bgColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        _label,
        style: TextStyle(
          fontSize: 11.sp,
          fontWeight: FontWeight.w600,
          color: _textColor,
        ),
      ),
    );
  }
}
