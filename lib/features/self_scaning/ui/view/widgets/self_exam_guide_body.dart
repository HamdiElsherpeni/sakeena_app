import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sakeena_app/core/resources/app_colors.dart';
import 'package:sakeena_app/core/utils/app_router.dart';
import 'package:sakeena_app/features/self_scaning/data/models/step_model.dart';

import 'step_badge.dart';
import 'instruction_card.dart';
import 'tips_list.dart';
import 'reminder_card.dart';

class SelfExamGuideBody extends StatelessWidget {
  final int currentIndex;
  final ExamStep step;

  const SelfExamGuideBody({
    super.key,
    required this.currentIndex,
    required this.step,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 350),
        transitionBuilder: (child, animation) => FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.05, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        ),
        child: _StepContent(key: ValueKey(currentIndex), step: step),
      ),
    );
  }
}

// ── محتوى الخطوة الواحدة ─────────────────────────────────────────────────────
class _StepContent extends StatelessWidget {
  final ExamStep step;

  const _StepContent({super.key, required this.step});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: StepBadge(
              stepNumber: step.stepNumber,
              totalSteps: step.totalSteps,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            step.title,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            step.subtitle,
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 13.sp, color: AppColors.textSecondary),
          ),
          SizedBox(height: 16.h),
          InstructionCard(instruction: step.instruction),
          SizedBox(height: 20.h),
          TipsList(tips: step.tips),
          if (step.isLastStep &&
              step.reminderText != null &&
              step.reminderCallToAction != null) ...[
            SizedBox(height: 24.h),
            ReminderCard(
              reminderText: step.reminderText!,
              callToActionLabel: step.reminderCallToAction!,
              onCallToAction: () {
                context.push(AppRouter.kChatView);
              },
            ),
          ],
        ],
      ),
    );
  }
}
