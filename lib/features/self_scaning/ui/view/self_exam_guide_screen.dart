import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakeena_app/core/resources/app_colors.dart';
import 'package:sakeena_app/features/self_scaning/data/models/step_model.dart';

import 'widgets/exam_guide_app_bar.dart';
import 'widgets/step_progress_bar.dart';
import 'widgets/step_navigation_buttons.dart';
import 'widgets/self_exam_guide_body.dart';

class SelfExamGuideScreen extends StatefulWidget {
  const SelfExamGuideScreen({super.key});

  @override
  State<SelfExamGuideScreen> createState() => _SelfExamGuideScreenState();
}

class _SelfExamGuideScreenState extends State<SelfExamGuideScreen> {
  int _currentIndex = 0;

  ExamStep get _currentStep => examSteps[_currentIndex];

  void _goNext() {
    if (_currentIndex < examSteps.length - 1) {
      setState(() => _currentIndex++);
    } else {
      Navigator.of(context).pop();
    }
  }

  void _goPrev() {
    if (_currentIndex > 0) {
      setState(() => _currentIndex--);
    }
  }

  @override
  Widget build(BuildContext context) {
    final step = _currentStep;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.kprimaryColor,
        appBar: ExamGuideAppBar(onBack: () => Navigator.of(context).maybePop()),
        body: Column(
          children: [
            StepProgressBar(
              currentStep: step.stepNumber,
              totalSteps: step.totalSteps,
            ),
            Expanded(
              child: SelfExamGuideBody(currentIndex: _currentIndex, step: step),
            ),
            Container(
              color: AppColors.white,
              padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 24.h),
              child: StepNavigationButtons(
                isFirstStep: _currentIndex == 0,
                isLastStep: step.isLastStep,
                onNext: _goNext,
                onPrev: _goPrev,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
