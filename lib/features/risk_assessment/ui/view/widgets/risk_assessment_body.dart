import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakeena_app/core/resources/app_colors.dart';
import 'package:sakeena_app/features/risk_assessment/logic/cubit/risk_assessment_cubit.dart';
import 'package:sakeena_app/features/risk_assessment/logic/cubit/risk_assessment_state.dart';
import 'package:sakeena_app/features/risk_assessment/ui/view/widgets/assessment_action_buttons.dart';
import 'package:sakeena_app/features/risk_assessment/ui/view/widgets/assessment_app_bar.dart';
import 'package:sakeena_app/features/risk_assessment/ui/view/widgets/assessment_data.dart';
import 'package:sakeena_app/features/risk_assessment/ui/view/widgets/assessment_questions_section.dart';
import 'package:sakeena_app/features/risk_assessment/ui/view/widgets/assessment_result_card.dart';
import 'package:sakeena_app/features/risk_assessment/ui/view/widgets/assessment_risk_gauge.dart';

class AssessmentScreenBody extends StatelessWidget {
  const AssessmentScreenBody({super.key});

  // ── helper: map API string → RiskLevel ───────────────────────────────────
  RiskLevel _parseRisk(String value) {
    switch (value.toLowerCase()) {
      case 'high':
        return RiskLevel.high;
      case 'medium':
      case 'moderate':
        return RiskLevel.medium;
      default:
        return RiskLevel.low;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RiskAssessmentCubit, RiskAssessmentState>(
      listener: (context, state) {
        if (state is RiskAssessmentFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red.shade700,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        final cubit = context.read<RiskAssessmentCubit>();

        final isResult = state is RiskAssessmentSuccess;
        final isLoading = state is RiskAssessmentLoading;
        final isForm = state is RiskAssessmentFormState;

        final currentStep = isForm
            ? (state as RiskAssessmentFormState).currentStep
            : 4;
        final currentQuestions = stepQuestions[currentStep] ?? [];

        return Container(
          color: AppColors.kprimaryColor,
          child: SafeArea(
            child: Column(
              children: [
                // ── AppBar ──────────────────────────────────────────────
                AssessmentAppBar(
                  showResult: isResult,
                  currentStep: currentStep,
                  onBack: isResult ? cubit.reset : cubit.previousStep,
                ),

                SizedBox(height: 18.h),

                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18.w),
                    child: Column(
                      children: [
                        Expanded(
                          child: isLoading
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.primary,
                                  ),
                                )
                              : SingleChildScrollView(
                                  physics: const BouncingScrollPhysics(),
                                  child: isResult
                                      ? AssessmentResultCard(
                                          overallRisk: _parseRisk(
                                            (state as RiskAssessmentSuccess)
                                                .response
                                                .overallRiskLevel,
                                          ),
                                          familyHistory: _parseRisk(
                                            state.response.familyHistoryRisk,
                                          ),
                                          lifestyle: _parseRisk(
                                            state.response.lifestyleRisk,
                                          ),
                                          geneticFactors: _parseRisk(
                                            state.response.geneticRisk,
                                          ),
                                          recommendation:
                                              state
                                                  .response
                                                  .recommendation
                                                  .isNotEmpty
                                              ? state.response.recommendation
                                              : 'ننصح بإجراء فحص دوري كل 6 أشهر ومتابعة مع الطبيب المختص.',
                                        )
                                      : isForm
                                      ? AssessmentQuestionsSection(
                                          currentQuestions: currentQuestions,
                                          currentStep: currentStep,
                                          // نمرر الـ label المختار بناءً على الـ int المحفوظ في الـ cubit
                                          answers: _buildLabelAnswers(
                                            state as RiskAssessmentFormState,
                                            currentStep,
                                            currentQuestions,
                                          ),
                                          stepBaseNumber: _baseNumber(
                                            currentStep,
                                          ),
                                          onSelect: (key, label) {
                                            // key = "step-index" → نستخرج fieldName والـ int value
                                            final parts = key.split('-');
                                            final qIndex = int.parse(parts[1]);
                                            final q = currentQuestions[qIndex];
                                            final optionIndex = q.options
                                                .indexOf(label);
                                            if (optionIndex != -1) {
                                              cubit.selectAnswer(
                                                q.fieldName,
                                                q.optionValues[optionIndex],
                                              );
                                            }
                                          },
                                        )
                                      : const SizedBox.shrink(),
                                ),
                        ),

                        SizedBox(height: 14.h),

                        // ── Action buttons ───────────────────────────────
                        if (!isResult && !isLoading && isForm)
                          AssessmentActionButtons(
                            currentStep: currentStep,
                            stepComplete: cubit.isCurrentStepComplete,
                            onBack: cubit.previousStep,
                            onNext: cubit.nextStep,
                          ),

                        SizedBox(height: 14.h),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ── بيبني map من "step-index" → label المختار ─────────────────────────────
  // عشان `AssessmentQuestionsSection` يعرف يعرض الـ selected option
  Map<String, String> _buildLabelAnswers(
    RiskAssessmentFormState formState,
    int step,
    List<QuestionModel> questions,
  ) {
    final map = <String, String>{};
    for (var i = 0; i < questions.length; i++) {
      final q = questions[i];
      final intValue = formState.answers[q.fieldName];
      if (intValue != null) {
        final optionIndex = q.optionValues.indexOf(intValue);
        if (optionIndex != -1) {
          map['$step-$i'] = q.options[optionIndex];
        }
      }
    }
    return map;
  }

  int _baseNumber(int step) {
    switch (step) {
      case 1:
        return 1;
      case 2:
        return 4;
      case 3:
        return 7;
      case 4:
        return 10;
      default:
        return 1;
    }
  }
}
