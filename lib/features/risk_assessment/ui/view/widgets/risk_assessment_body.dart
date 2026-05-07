import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakeena_app/core/resources/app_colors.dart';
import 'package:sakeena_app/features/risk_assessment/ui/view/widgets/assessment_action_buttons.dart';
import 'package:sakeena_app/features/risk_assessment/ui/view/widgets/assessment_app_bar.dart';
import 'package:sakeena_app/features/risk_assessment/ui/view/widgets/assessment_data.dart';
import 'package:sakeena_app/features/risk_assessment/ui/view/widgets/assessment_questions_section.dart';
import 'package:sakeena_app/features/risk_assessment/ui/view/widgets/assessment_result_card.dart';
import 'package:sakeena_app/features/risk_assessment/ui/view/widgets/assessment_risk_gauge.dart';

class AssessmentScreenBody extends StatefulWidget {
  const AssessmentScreenBody({super.key});

  @override
  State<AssessmentScreenBody> createState() => _AssessmentScreenBodyState();
}

class _AssessmentScreenBodyState extends State<AssessmentScreenBody> {
  int _currentStep = 1;
  bool _showResult = false;

  final Map<String, String> _answers = {};

  List<QuestionModel> getCurrentQuestions() {
    return stepQuestions[_currentStep]!;
  }

  bool get _stepComplete {
    final currentQuestions = getCurrentQuestions();

    for (var i = 0; i < currentQuestions.length; i++) {
      if (_answers['$_currentStep-$i'] == null) {
        return false;
      }
    }
    return true;
  }

  void _next() {
    if (_currentStep < 4) {
      setState(() => _currentStep++);
    } else {
      setState(() => _showResult = true);
    }
  }

  void _back() {
    if (_showResult) {
      setState(() => _showResult = false);
    } else if (_currentStep > 1) {
      setState(() => _currentStep--);
    }
  }

  RiskLevel _calcOverall() {
    final highSignals = [
      _answers['3-1'] == 'نعم',
      _answers['3-0'] == 'أكثر من قريبة',
      _answers['2-2']?.contains('HRT') ?? false,
    ].where((e) => e).length;

    if (highSignals >= 2) return RiskLevel.high;
    if (highSignals == 1) return RiskLevel.medium;
    return RiskLevel.low;
  }

  RiskLevel _calcFamily() {
    final ans = _answers['3-0'];
    if (ans == 'أكثر من قريبة') return RiskLevel.high;
    if (ans == 'قريبة واحدة فقط') return RiskLevel.medium;
    return RiskLevel.low;
  }

  RiskLevel _calcLifestyle() {
    final bmi = _answers['1-2'];
    if (bmi == 'سمنة (أكثر من 30)') return RiskLevel.high;
    if (bmi == 'زيادة في الوزن') return RiskLevel.medium;
    return RiskLevel.low;
  }

  RiskLevel _calcGenetic() {
    final brca = _answers['3-1'];
    if (brca == 'نعم') return RiskLevel.high;

    final familyHistory = _answers['3-0'];
    if (familyHistory == 'أكثر من قريبة') return RiskLevel.medium;

    return RiskLevel.low;
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestions = getCurrentQuestions();

    return Container(
      color: AppColors.kprimaryColor,
      child: SafeArea(
        child: Column(
          children: [
            AssessmentAppBar(
              showResult: _showResult,
              currentStep: _currentStep,
              onBack: _back,
            ),

            SizedBox(height: 18.h),

            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.w),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: _showResult
                            ? AssessmentResultCard(
                                overallRisk: _calcOverall(),
                                familyHistory: _calcFamily(),
                                lifestyle: _calcLifestyle(),
                                geneticFactors: _calcGenetic(),
                                recommendation:
                                    'ننصح بإجراء فحص دوري كل 6 أشهر ومتابعة مع الطبيب المختص.',
                              )
                            : AssessmentQuestionsSection(
                                currentQuestions: currentQuestions,
                                currentStep: _currentStep,
                                answers: _answers,
                                stepBaseNumber: _currentStep,
                                onSelect: (key, value) {
                                  setState(() {
                                    _answers[key] = value;
                                  });
                                },
                              ),
                      ),
                    ),

                    SizedBox(height: 14.h),

                    if (!_showResult)
                      AssessmentActionButtons(
                        currentStep: _currentStep,
                        stepComplete: _stepComplete,
                        onBack: _back,
                        onNext: _next,
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
  }
}
