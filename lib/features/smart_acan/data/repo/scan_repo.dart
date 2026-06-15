import 'dart:io';
import 'package:sakeena_app/features/exam_history/data/models/prediction_history_model.dart';
import 'package:sakeena_app/features/smart_acan/data/models/scan_result_model.dart';

abstract class ScanRepo {
  Future<ScanResultModel> predict(File imageFile);
  Future<List<PredictionHistoryModel>> getHistory();
  Future<List<PredictionHistoryModel>> getHistoryWithStatus(String status);
  Future<PredictionStatisticsModel> getStatistics();
}