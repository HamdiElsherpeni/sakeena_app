import 'dart:io';
import 'package:dio/dio.dart';
import 'package:sakeena_app/core/errors/failer.dart';
import 'package:sakeena_app/core/network/api_client.dart';
import 'package:sakeena_app/core/network/api_endpoints.dart';
import '../models/scan_result_model.dart';
import '../models/prediction_history_model.dart';

class ScanRemoteDatasource {
  // ─── Predict ──────────────────────────────────────────────────────────────
  Future<ScanResultModel> predict(File imageFile) async {
    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          imageFile.path,
          filename: imageFile.path.split('/').last,
        ),
      });

      final response = await ApiClient.post(
        ApiEndpoints.predict,
        data: formData,
      );

      return ScanResultModel.fromJson(response);
    } on DioException catch (e) {
      throw ServerFailer.fromDioError(e);
    } on Failer {
      rethrow; // ✅ لو ApiClient رماها خليها تعدي
    } catch (e) {
      throw ServerFailer('فشل تحليل الصورة. حاولي مرة أخرى.');
    }
  }

  // ─── Get History ──────────────────────────────────────────────────────────
  Future<List<PredictionHistoryModel>> getHistory() async {
    try {
      final response = await ApiClient.get(ApiEndpoints.predictionHistory);
      final list = response['data'] ?? response;
      return (list as List)
          .map((e) => PredictionHistoryModel.fromJson(e))
          .toList();
    } on Failer {
      rethrow;
    } catch (e) {
      throw ServerFailer('فشل تحميل السجل. حاولي مرة أخرى.');
    }
  }

  // ─── Get History With Status ──────────────────────────────────────────────
  Future<List<PredictionHistoryModel>> getHistoryWithStatus(
    String status,
  ) async {
    try {
      final response = await ApiClient.get(
        ApiEndpoints.predictionHistoryWithStatus,
        queryParameters: {'status': status},
      );
      final list = response['data'] ?? response;
      return (list as List)
          .map((e) => PredictionHistoryModel.fromJson(e))
          .toList();
    } on Failer {
      rethrow;
    } catch (e) {
      throw ServerFailer('فشل تحميل السجل. حاولي مرة أخرى.');
    }
  }

  // ─── Get Statistics ───────────────────────────────────────────────────────
  Future<PredictionStatisticsModel> getStatistics() async {
    try {
      final response = await ApiClient.get(ApiEndpoints.predictionStatistics);
      return PredictionStatisticsModel.fromJson(response);
    } on Failer {
      rethrow;
    } catch (e) {
      throw ServerFailer('فشل تحميل الإحصائيات. حاولي مرة أخرى.');
    }
  }
}
