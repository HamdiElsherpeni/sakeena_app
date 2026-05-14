import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:sakeena_app/core/errors/failer.dart';
import 'package:sakeena_app/features/risk_assessment/data/datasources/risk_assessment_remote_datasource.dart';
import 'package:sakeena_app/features/risk_assessment/data/models/risk_assessment_request_model.dart';
import 'package:sakeena_app/features/risk_assessment/data/models/risk_assessment_response_model.dart';
import 'package:sakeena_app/features/risk_assessment/data/repositories/risk_assessment_repository.dart';

class RiskAssessmentRepoImplement implements RiskAssessmentRepository {
  final RiskAssessmentRemoteDatasource _datasource;

  RiskAssessmentRepoImplement(this._datasource);

  @override
  Future<Either<Failer, RiskAssessmentResponse>> assess(
    RiskAssessmentRequest request,
  ) async {
    try {
      final result = await _datasource.assess(request);
      return right(result);
    } on DioException catch (e) {
      return left(ServerFailer.fromDioError(e));
    } catch (e) {
      return left(ServerFailer(e.toString()));
    }
  }
}
