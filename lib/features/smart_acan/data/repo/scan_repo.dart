import 'dart:io';
import '../models/scan_result_model.dart';
import '../models/prediction_history_model.dart';

abstract class ScanRepo {
  Future<ScanResultModel> predict(File imageFile);
  Future<List<PredictionHistoryModel>> getHistory();
  Future<List<PredictionHistoryModel>> getHistoryWithStatus(String status);
  Future<PredictionStatisticsModel> getStatistics();
}
