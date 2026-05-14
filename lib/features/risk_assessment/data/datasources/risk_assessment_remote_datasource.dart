import 'package:sakeena_app/core/network/api_endpoints.dart';
import 'package:sakeena_app/core/network/dio_factory.dart';
import 'package:sakeena_app/features/risk_assessment/data/models/risk_assessment_request_model.dart';
import 'package:sakeena_app/features/risk_assessment/data/models/risk_assessment_response_model.dart';

class RiskAssessmentRemoteDatasource {
  Future<RiskAssessmentResponse> assess(RiskAssessmentRequest request) async {
    final response = await DioFactory.dio.post(
      ApiEndpoints.riskAssessment,
      data: request.toJson(),
    );
    return RiskAssessmentResponse.fromJson(
      response.data as Map<String, dynamic>,
    );
  }
}
