import 'package:dartz/dartz.dart';
import 'package:sakeena_app/core/errors/failer.dart';
import 'package:sakeena_app/features/risk_assessment/data/models/risk_assessment_request_model.dart';
import 'package:sakeena_app/features/risk_assessment/data/models/risk_assessment_response_model.dart';

abstract class RiskAssessmentRepository {
  Future<Either<Failer, RiskAssessmentResponse>> assess(
    RiskAssessmentRequest request,
  );
}
