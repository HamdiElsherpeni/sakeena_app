import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakeena_app/core/resources/app_colors.dart';
import 'package:sakeena_app/core/widgets/coustem_eleveted_butten.dart';
import 'package:sakeena_app/features/risk_assessment/logic/cubit/risk_assessment_cubit.dart';
import 'package:sakeena_app/features/risk_assessment/ui/view/widgets/assessment_risk_gauge.dart';
import 'package:sakeena_app/features/risk_assessment/ui/view/widgets/risk_factor_row.dart';

class AssessmentResultCard extends StatelessWidget {
  final RiskLevel overallRisk;
  final RiskLevel familyHistory;
  final RiskLevel lifestyle;
  final RiskLevel geneticFactors;
  final String recommendation;

  const AssessmentResultCard({
    super.key,
    required this.overallRisk,
    required this.familyHistory,
    required this.lifestyle,
    required this.geneticFactors,
    required this.recommendation,
  });

  String get _riskTitle {
    switch (overallRisk) {
      case RiskLevel.low:
        return 'خطر منخفض';
      case RiskLevel.medium:
        return 'خطر متوسط';
      case RiskLevel.high:
        return 'خطر عالي';
    }
  }

  Color get _riskCircleColor {
    switch (overallRisk) {
      case RiskLevel.low:
        return const Color(0xFFE8F5E9);
      case RiskLevel.medium:
        return const Color(0xFFFFF8E1);
      case RiskLevel.high:
        return const Color(0xFFFFEBEE);
    }
  }

  Color get _riskIconColor {
    switch (overallRisk) {
      case RiskLevel.low:
        return const Color(0xFF4CAF50);
      case RiskLevel.medium:
        return const Color(0xFFFFC107);
      case RiskLevel.high:
        return const Color(0xFFF44336);
    }
  }

  IconData get _riskIcon {
    switch (overallRisk) {
      case RiskLevel.low:
        return Icons.check_circle_outline_rounded;
      case RiskLevel.medium:
      case RiskLevel.high:
        return Icons.warning_amber_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ── Overall risk circle ────────────────────────────────────
        Container(
          width: 90.r,
          height: 90.r,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _riskCircleColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(_riskIcon, color: _riskIconColor, size: 28.r),
              SizedBox(height: 4.h),
              Text(
                _riskTitle,
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  color: _riskIconColor,
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 24.h),

        // ── Gauge bar ─────────────────────────────────────────────
        AssessmentRiskGauge(riskLevel: overallRisk),

        SizedBox(height: 28.h),

        // ── Risk factors section ───────────────────────────────────
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            'عوامل الخطر',
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xff2D1A1A),
            ),
          ),
        ),
        SizedBox(height: 12.h),
        RiskFactorRow(label: 'التاريخ العائلي', riskLevel: familyHistory),
        RiskFactorRow(label: 'نمط الحياة', riskLevel: lifestyle),
        RiskFactorRow(label: 'العوامل الوراثية', riskLevel: geneticFactors),

        SizedBox(height: 16.h),

        CoustemElevetedBoutten(
          text: 'اعادة التقييم الصحي  ',
          onPressed: () => context.read<RiskAssessmentCubit>().reset(),
          backgroundcolor: AppColors.primary,
          textcolor: Colors.white,
        ),

        SizedBox(height: 16.h),

        // ── Recommendations box ────────────────────────────────────
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            color: const Color(0xffFFF5CE),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: const Color(0xffE8C97A), width: 1.w),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('♡', style: TextStyle(fontSize: 20.sp)),
              SizedBox(width: 8.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'نصيحة اليوم',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xff7A6060),
                      ),
                    ),
                    Text(
                      recommendation,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: const Color(0xff7A6060),
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8.w),
            ],
          ),
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
}
