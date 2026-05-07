import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakeena_app/features/exam_history/data/models/prediction_history_model.dart';
import 'package:sakeena_app/features/exam_history/data/repos/prediction_history_repo.dart';

part 'prediction_history_state.dart';

class PredictionHistoryCubit extends Cubit<PredictionHistoryState> {
  PredictionHistoryCubit(this._repo) : super(PredictionHistoryInitial());

  final PredictionHistoryRepo _repo;

  List<PredictionHistoryModel> _allExams = [];
  String _activeFilter = 'all';
  bool _sortAscending = false; // false = أحدث أولاً (default)

  // ─── Load ─────────────────────────────────────────────────────────────────

  Future<void> loadHistory() async {
    emit(PredictionHistoryLoading());

    final result = await _repo.getHistory();

    result.fold(
      (failure) => emit(PredictionHistoryFailure(failure.errorMessage)),
      (exams) {
        _allExams = List<PredictionHistoryModel>.from(exams);
        _activeFilter = 'all';
        _sortAscending = false;
        emit(
          PredictionHistorySuccess(
            exams: _applySortAndFilter(),
            activeFilter: _activeFilter,
            sortAscending: _sortAscending,
          ),
        );
      },
    );
  }

  // ─── Filter ───────────────────────────────────────────────────────────────

  void filterByStatus(String status) {
    _activeFilter = status;
    emit(
      PredictionHistorySuccess(
        exams: _applySortAndFilter(),
        activeFilter: _activeFilter,
        sortAscending: _sortAscending,
      ),
    );
  }

  // ─── Sort ─────────────────────────────────────────────────────────────────

  void toggleSort() {
    _sortAscending = !_sortAscending;

    // نشيل الـ PredictionReportLoading/Success/Failure ونرجع لـ Success
    emit(
      PredictionHistorySuccess(
        exams: _applySortAndFilter(),
        activeFilter: _activeFilter,
        sortAscending: _sortAscending,
      ),
    );
  }

  // ─── Download Report ──────────────────────────────────────────────────────

  Future<void> downloadReport(int predictionId) async {
    // نحتفظ بالـ list ظاهرة وقت التحميل
    final exams = _applySortAndFilter();

    emit(
      PredictionReportLoading(
        predictionId: predictionId,
        exams: exams,
        activeFilter: _activeFilter,
        sortAscending: _sortAscending,
      ),
    );

    final result = await _repo.downloadReport(predictionId);

    result.fold(
      (failure) => emit(
        PredictionReportFailure(
          message: failure.errorMessage,
          exams: exams,
          activeFilter: _activeFilter,
          sortAscending: _sortAscending,
        ),
      ),
      (url) => emit(
        PredictionReportSuccess(
          reportUrl: url,
          exams: exams,
          activeFilter: _activeFilter,
          sortAscending: _sortAscending,
        ),
      ),
    );
  }

  // ─── Private Helpers ──────────────────────────────────────────────────────

  /// يطبّق الـ filter والـ sort على _allExams دايماً من الـ source الأصلي
  List<PredictionHistoryModel> _applySortAndFilter() {
    var result = _activeFilter == 'all'
        ? List<PredictionHistoryModel>.from(_allExams)
        : _allExams.where((e) => e.status == _activeFilter).toList();

    result.sort((a, b) {
      final dateA = DateTime.tryParse(a.predictionDate) ?? DateTime(0);
      final dateB = DateTime.tryParse(b.predictionDate) ?? DateTime(0);
      return _sortAscending ? dateA.compareTo(dateB) : dateB.compareTo(dateA);
    });

    return result;
  }
}
