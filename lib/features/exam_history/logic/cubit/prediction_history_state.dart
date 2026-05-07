part of 'prediction_history_cubit.dart';

abstract class PredictionHistoryState {}

class PredictionHistoryInitial extends PredictionHistoryState {}

class PredictionHistoryLoading extends PredictionHistoryState {}

class PredictionHistorySuccess extends PredictionHistoryState {
  final List<PredictionHistoryModel> exams;
  final String activeFilter; // 'all' | 'Benign' | 'Malignant'
  final bool sortAscending; // false = أحدث أولاً

  PredictionHistorySuccess({
    required this.exams,
    required this.sortAscending,
    this.activeFilter = 'all',
  });
}

class PredictionHistoryFailure extends PredictionHistoryState {
  final String message;
  PredictionHistoryFailure(this.message);
}

// ─── Report states (الـ list لازم تفضل ظاهرة) ───────────────────────────────

class PredictionReportLoading extends PredictionHistoryState {
  final int predictionId;
  final List<PredictionHistoryModel> exams;
  final String activeFilter;
  final bool sortAscending;

  PredictionReportLoading({
    required this.predictionId,
    required this.exams,
    required this.activeFilter,
    required this.sortAscending,
  });
}

class PredictionReportSuccess extends PredictionHistoryState {
  final String reportUrl;
  final List<PredictionHistoryModel> exams;
  final String activeFilter;
  final bool sortAscending;

  PredictionReportSuccess({
    required this.reportUrl,
    required this.exams,
    required this.activeFilter,
    required this.sortAscending,
  });
}

class PredictionReportFailure extends PredictionHistoryState {
  final String message;
  final List<PredictionHistoryModel> exams;
  final String activeFilter;
  final bool sortAscending;

  PredictionReportFailure({
    required this.message,
    required this.exams,
    required this.activeFilter,
    required this.sortAscending,
  });
}
