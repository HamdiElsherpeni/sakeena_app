import 'package:flutter/material.dart';
import 'package:sakeena_app/features/risk_assessment/ui/view/widgets/assessment_data.dart';
import 'package:sakeena_app/features/risk_assessment/ui/view/widgets/assessment_question_card.dart';

class AssessmentQuestionsSection extends StatelessWidget {
  const AssessmentQuestionsSection({
    super.key,
    required this.currentQuestions,
    required this.currentStep,
    required this.answers,
    required this.stepBaseNumber,
    required this.onSelect,
  });

  final List<QuestionModel> currentQuestions;
  final int currentStep;
  final Map<String, String> answers;
  final int stepBaseNumber;

  final Function(String key, String value) onSelect;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        currentQuestions.length,
        (i) => AssessmentQuestionCard(
          questionNumber: '${stepBaseNumber + i}',
          questionText: currentQuestions[i].text,
          options: currentQuestions[i].options,
          selectedOption: answers['$currentStep-$i'],
          onOptionSelected: (val) {
            onSelect('$currentStep-$i', val);
          },
        ),
      ),
    );
  }
}
