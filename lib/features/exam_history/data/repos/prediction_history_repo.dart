import 'package:dartz/dartz.dart';
import 'package:sakeena_app/core/errors/failer.dart';
import 'package:sakeena_app/core/network/api_endpoints.dart';
import 'package:sakeena_app/core/network/api_services.dart';
import '../models/prediction_history_model.dart';

abstract class PredictionHistoryRepo {
  Future<Either<Failer, List<PredictionHistoryModel>>> getHistory();

  Future<Either<Failer, List<PredictionHistoryModel>>> getHistoryByStatus(
    String status,
  );

  Future<Either<Failer, String>> downloadReport(int predictionId);
}

class PredictionHistoryRepoImpl implements PredictionHistoryRepo {
  const PredictionHistoryRepoImpl();

  @override
  Future<Either<Failer, List<PredictionHistoryModel>>> getHistory() async {
    try {
      final response = await ApiService.get(ApiEndpoints.predictionHistory);

      final rawList = response['data'];
      if (rawList == null) return const Right([]);

      final list = (rawList as List)
          .map(
            (e) => PredictionHistoryModel.fromJson(e as Map<String, dynamic>),
          )
          .toList();

      return Right(list);
    } on ServerFailer catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailer('حدث خطأ غير متوقع. يرجى المحاولة مرة أخرى.'));
    }
  }

  @override
  Future<Either<Failer, List<PredictionHistoryModel>>> getHistoryByStatus(
    String status,
  ) async {
    try {
      final response = await ApiService.get(
        ApiEndpoints.predictionHistoryWithStatus,
        queryParameters: {'status': status},
      );

      final rawList = response['data'];
      if (rawList == null) return const Right([]);

      final list = (rawList as List)
          .map(
            (e) => PredictionHistoryModel.fromJson(e as Map<String, dynamic>),
          )
          .toList();

      return Right(list);
    } on ServerFailer catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailer('حدث خطأ غير متوقع. يرجى المحاولة مرة أخرى.'));
    }
  }

  @override
  Future<Either<Failer, String>> downloadReport(int predictionId) async {
    try {
      final response = await ApiService.get(
        '${ApiEndpoints.predictionHistory}/report',
        queryParameters: {'id': predictionId},
      );

      final url =
          response['reportUrl'] as String? ??
          response['url'] as String? ??
          response['data'] as String? ??
          '';

      return Right(url);
    } on ServerFailer catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailer('حدث خطأ في تحميل التقرير.'));
    }
  }
}
