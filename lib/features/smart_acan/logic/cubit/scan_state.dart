part of 'scan_cubit.dart';

abstract class ScanState {}

class ScanInitial extends ScanState {}

class ScanLoading extends ScanState {}

class ScanSuccess extends ScanState {
  final ScanResultModel result;
  ScanSuccess(this.result);
}

class HistoryLoaded extends ScanState {
  final List<PredictionHistoryModel> history;
  HistoryLoaded(this.history);
}

class StatisticsLoaded extends ScanState {
  final PredictionStatisticsModel statistics;
  StatisticsLoaded(this.statistics);
}

class ScanError extends ScanState {
  final String message;
  ScanError(this.message);
}