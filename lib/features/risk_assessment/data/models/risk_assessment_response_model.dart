class RiskAssessmentResponse {
  final String overallRiskLevel;
  final String familyHistoryRisk;
  final String lifestyleRisk;
  final String geneticRisk;
  final String recommendation;

  const RiskAssessmentResponse({
    required this.overallRiskLevel,
    required this.familyHistoryRisk,
    required this.lifestyleRisk,
    required this.geneticRisk,
    required this.recommendation,
  });

  factory RiskAssessmentResponse.fromJson(Map<String, dynamic> json) =>
      RiskAssessmentResponse(
        overallRiskLevel: json['overallRiskLevel']?.toString() ?? '',
        familyHistoryRisk: json['familyHistoryRisk']?.toString() ?? '',
        lifestyleRisk: json['lifestyleRisk']?.toString() ?? '',
        geneticRisk: json['geneticRisk']?.toString() ?? '',
        recommendation: json['recommendation']?.toString() ?? '',
      );
}
