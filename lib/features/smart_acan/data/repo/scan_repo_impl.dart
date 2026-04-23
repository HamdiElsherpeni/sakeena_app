import 'dart:io';
import 'package:sakeena_app/features/smart_acan/data/data_source/scan_remote_datasource.dart';
import 'package:sakeena_app/features/smart_acan/data/models/scan_result_model.dart';
import 'package:sakeena_app/features/smart_acan/data/models/prediction_history_model.dart';
import 'scan_repo.dart';

class ScanRepoImpl implements ScanRepo {
  final ScanRemoteDatasource _datasource;

  ScanRepoImpl(this._datasource);

  @override
  Future<ScanResultModel> predict(File imageFile) =>
      _datasource.predict(imageFile);

  @override
  Future<List<PredictionHistoryModel>> getHistory() => _datasource.getHistory();

  @override
  Future<List<PredictionHistoryModel>> getHistoryWithStatus(String status) =>
      _datasource.getHistoryWithStatus(status);

  @override
  Future<PredictionStatisticsModel> getStatistics() =>
      _datasource.getStatistics();
}
