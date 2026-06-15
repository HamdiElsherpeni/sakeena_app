import 'dart:io';
import 'package:dio/dio.dart';
import 'package:sakeena_app/core/errors/failer.dart';
import 'package:sakeena_app/core/network/api_client.dart';
import 'package:sakeena_app/core/network/api_endpoints.dart';
import 'package:sakeena_app/features/exam_history/data/models/prediction_history_model.dart';
import 'package:sakeena_app/features/smart_acan/data/models/scan_result_model.dart';

class ScanRemoteDatasource {
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
    } on Failer {
      rethrow;
    } catch (e) {
      throw ServerFailer('فشل تحليل الصورة. حاولي مرة أخرى.');
    }
  }

  Future<List<PredictionHistoryModel>> getHistory() async {
    try {
      final response = await ApiClient.get(ApiEndpoints.predictionHistory);
      final raw = response['data'] ?? response['items'] ?? response;
      final list = raw is List ? raw : <dynamic>[];
      return list
          .map((e) => PredictionHistoryModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on Failer {
      rethrow;
    } catch (e) {
      throw ServerFailer('فشل تحميل السجل. حاولي مرة أخرى.');
    }
  }

  Future<List<PredictionHistoryModel>> getHistoryWithStatus(String status) async {
    try {
      final response = await ApiClient.get(
        ApiEndpoints.predictionHistoryWithStatus,
        queryParameters: {'status': status},
      );
      final raw = response['data'] ?? response['items'] ?? response;
      final list = raw is List ? raw : <dynamic>[];
      return list
          .map((e) => PredictionHistoryModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on Failer {
      rethrow;
    } catch (e) {
      throw ServerFailer('فشل تحميل السجل. حاولي مرة أخرى.');
    }
  }

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