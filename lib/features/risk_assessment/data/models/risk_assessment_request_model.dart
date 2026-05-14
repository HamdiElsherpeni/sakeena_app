// ─── Enums matching API integer values ───────────────────────────────────────

enum AgeGroup {
  under30(0),
  age30to39(1),
  age40to50(2),
  above50(3);

  final int value;
  const AgeGroup(this.value);
}

enum Ethnicity {
  arabCaucasian(0),
  other(1);

  final int value;
  const Ethnicity(this.value);
}

enum BmiCategory {
  normal(0),
  overweight(1),
  obese(2);

  final int value;
  const BmiCategory(this.value);
}

enum MenarcheAge {
  before12(0),
  between12and14(1),
  after14(2);

  final int value;
  const MenarcheAge(this.value);
}

enum PregnancyHistory {
  firstBirthBefore30(0),
  firstBirthAfter30(1),
  noPregnancy(2);

  final int value;
  const PregnancyHistory(this.value);
}

enum MenopauseStatus {
  notYet(0),
  withoutHrt(1),
  withHrt(2);

  final int value;
  const MenopauseStatus(this.value);
}

enum FamilyHistoryLevel {
  none(0),
  oneRelative(1),
  moreThanOne(2);

  final int value;
  const FamilyHistoryLevel(this.value);
}

enum EarlyFamilyDiagnosis {
  yes(0),
  no(1);

  final int value;
  const EarlyFamilyDiagnosis(this.value);
}

enum BrcaMutation {
  yes(0),
  noOrNotTested(1);

  final int value;
  const BrcaMutation(this.value);
}

enum BreastDensity {
  yes(0),
  no(1),
  neverHadXray(2);

  final int value;
  const BreastDensity(this.value);
}

enum BiopsyResult {
  yes(0),
  noOrBenign(1),
  noNeedForBiopsy(2);

  final int value;
  const BiopsyResult(this.value);
}

enum RadiationHistory {
  yes(0),
  no(1);

  final int value;
  const RadiationHistory(this.value);
}

// ─── Request model ────────────────────────────────────────────────────────────

class RiskAssessmentRequest {
  final AgeGroup ageGroup;
  final Ethnicity ethnicity;
  final BmiCategory bmiCategory;
  final MenarcheAge menarcheAge;
  final PregnancyHistory pregnancyHistory;
  final MenopauseStatus menopauseStatus;
  final FamilyHistoryLevel familyHistoryLevel;
  final EarlyFamilyDiagnosis earlyFamilyDiagnosis;
  final BrcaMutation brcaMutation;
  final BreastDensity breastDensity;
  final BiopsyResult biopsyResult;
  final RadiationHistory radiationHistory;

  const RiskAssessmentRequest({
    required this.ageGroup,
    required this.ethnicity,
    required this.bmiCategory,
    required this.menarcheAge,
    required this.pregnancyHistory,
    required this.menopauseStatus,
    required this.familyHistoryLevel,
    required this.earlyFamilyDiagnosis,
    required this.brcaMutation,
    required this.breastDensity,
    required this.biopsyResult,
    required this.radiationHistory,
  });

  Map<String, dynamic> toJson() => {
    'ageGroup': ageGroup.value,
    'ethnicity': ethnicity.value,
    'bmiCategory': bmiCategory.value,
    'menarcheAge': menarcheAge.value,
    'pregnancyHistory': pregnancyHistory.value,
    'menopauseStatus': menopauseStatus.value,
    'familyHistoryLevel': familyHistoryLevel.value,
    'earlyFamilyDiagnosis': earlyFamilyDiagnosis.value,
    'brcaMutation': brcaMutation.value,
    'breastDensity': breastDensity.value,
    'biopsyResult': biopsyResult.value,
    'radiationHistory': radiationHistory.value,
  };
}
