import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakeena_app/core/errors/failer.dart';
import 'package:sakeena_app/features/smart_acan/data/models/scan_result_model.dart';
import 'package:sakeena_app/features/smart_acan/data/models/prediction_history_model.dart';
import 'package:sakeena_app/features/smart_acan/data/repo/scan_repo.dart';

part 'scan_state.dart';

class ScanCubit extends Cubit<ScanState> {
  final ScanRepo _repo;

  ScanCubit(this._repo) : super(ScanInitial());

  ScanResultModel? lastResult;

  // ─── Predict ──────────────────────────────────────────────────────────────
  Future<void> predict(File imageFile) async {
    emit(ScanLoading());
    try {
      final result = await _repo.predict(imageFile);
      lastResult = result;
      emit(ScanSuccess(result));
    } on Failer catch (e) {
      emit(ScanError(e.errorMessage)); // ✅ رسالة من ServerFailer
    } catch (e) {
      emit(ScanError('Something went wrong'));
    }
  }

  // ─── Get History ──────────────────────────────────────────────────────────
  Future<void> getHistory() async {
    emit(ScanLoading());
    try {
      final history = await _repo.getHistory();
      emit(HistoryLoaded(history));
    } on Failer catch (e) {
      emit(ScanError(e.errorMessage));
    } catch (e) {
      emit(ScanError('Something went wrong'));
    }
  }

  // ─── Get History With Status ──────────────────────────────────────────────
  Future<void> getHistoryWithStatus(String status) async {
    emit(ScanLoading());
    try {
      final history = await _repo.getHistoryWithStatus(status);
      emit(HistoryLoaded(history));
    } on Failer catch (e) {
      emit(ScanError(e.errorMessage));
    } catch (e) {
      emit(ScanError('Something went wrong'));
    }
  }

  // ─── Get Statistics ───────────────────────────────────────────────────────
  Future<void> getStatistics() async {
    emit(ScanLoading());
    try {
      final statistics = await _repo.getStatistics();
      emit(StatisticsLoaded(statistics));
    } on Failer catch (e) {
      emit(ScanError(e.errorMessage));
    } catch (e) {
      emit(ScanError('Something went wrong'));
    }
  }
}
