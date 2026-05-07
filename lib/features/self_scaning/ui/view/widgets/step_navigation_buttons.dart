import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakeena_app/core/resources/app_colors.dart';
import 'package:sakeena_app/core/widgets/coustem_eleveted_butten.dart';

class StepNavigationButtons extends StatelessWidget {
  final bool isFirstStep;
  final bool isLastStep;
  final VoidCallback onNext;
  final VoidCallback onPrev;

  const StepNavigationButtons({
    super.key,
    required this.isFirstStep,
    required this.isLastStep,
    required this.onNext,
    required this.onPrev,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // ── السابق ────────────────────────────────────────────────────
        Expanded(
          child: CoustemElevetedBoutten(
            text: 'السابق',
            backgroundcolor: isFirstStep
                ? AppColors.grey
                : AppColors.kprimaryColor,
            textcolor: isFirstStep ? AppColors.white : AppColors.textDark,
            onPressed: isFirstStep ? null : onPrev,
            fontSize: 16,
          ),
        ),
        SizedBox(width: 12.w),
        // ── التالي / إنهاء ────────────────────────────────────────────
        Expanded(
          flex: 2,
          child: CoustemElevetedBoutten(
            text: isLastStep ? 'إنهاء' : 'التالي',
            backgroundcolor: AppColors.primary,
            onPressed: onNext,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
