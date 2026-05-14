import 'package:sakeena_app/features/risk_assessment/data/models/risk_assessment_request_model.dart';
import 'package:sakeena_app/features/risk_assessment/data/models/risk_assessment_response_model.dart';

abstract class RiskAssessmentState {}

class RiskAssessmentInitial extends RiskAssessmentState {}

class RiskAssessmentLoading extends RiskAssessmentState {}

class RiskAssessmentSuccess extends RiskAssessmentState {
  final RiskAssessmentResponse response;
  RiskAssessmentSuccess(this.response);
}

class RiskAssessmentFailure extends RiskAssessmentState {
  final String message;
  RiskAssessmentFailure(this.message);
}

// ── Form state: يتحكم في الـ step والإجابات ──────────────────────────────────

class RiskAssessmentFormState extends RiskAssessmentState {
  final int currentStep;
  final Map<String, int> answers; // fieldName → enum int value

  RiskAssessmentFormState({required this.currentStep, required this.answers});

  RiskAssessmentFormState copyWith({
    int? currentStep,
    Map<String, int>? answers,
  }) => RiskAssessmentFormState(
    currentStep: currentStep ?? this.currentStep,
    answers: answers ?? Map.from(this.answers),
  );

  bool isStepComplete(List<String> stepFields) =>
      stepFields.every((f) => answers.containsKey(f));

  RiskAssessmentRequest? buildRequest() {
    try {
      return RiskAssessmentRequest(
        ageGroup: AgeGroup.values.firstWhere(
          (e) => e.value == answers['ageGroup'],
        ),
        ethnicity: Ethnicity.values.firstWhere(
          (e) => e.value == answers['ethnicity'],
        ),
        bmiCategory: BmiCategory.values.firstWhere(
          (e) => e.value == answers['bmiCategory'],
        ),
        menarcheAge: MenarcheAge.values.firstWhere(
          (e) => e.value == answers['menarcheAge'],
        ),
        pregnancyHistory: PregnancyHistory.values.firstWhere(
          (e) => e.value == answers['pregnancyHistory'],
        ),
        menopauseStatus: MenopauseStatus.values.firstWhere(
          (e) => e.value == answers['menopauseStatus'],
        ),
        familyHistoryLevel: FamilyHistoryLevel.values.firstWhere(
          (e) => e.value == answers['familyHistoryLevel'],
        ),
        earlyFamilyDiagnosis: EarlyFamilyDiagnosis.values.firstWhere(
          (e) => e.value == answers['earlyFamilyDiagnosis'],
        ),
        brcaMutation: BrcaMutation.values.firstWhere(
          (e) => e.value == answers['brcaMutation'],
        ),
        breastDensity: BreastDensity.values.firstWhere(
          (e) => e.value == answers['breastDensity'],
        ),
        biopsyResult: BiopsyResult.values.firstWhere(
          (e) => e.value == answers['biopsyResult'],
        ),
        radiationHistory: RadiationHistory.values.firstWhere(
          (e) => e.value == answers['radiationHistory'],
        ),
      );
    } catch (_) {
      return null;
    }
  }
}
