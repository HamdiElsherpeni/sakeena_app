import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakeena_app/core/errors/failer.dart';
import 'package:sakeena_app/features/exam_history/data/models/prediction_history_model.dart';
import 'package:sakeena_app/features/smart_acan/data/models/scan_result_model.dart';
import 'package:sakeena_app/features/smart_acan/data/repo/scan_repo.dart';

part 'scan_state.dart';

class ScanCubit extends Cubit<ScanState> {
  final ScanRepo _repo;

  ScanCubit(this._repo) : super(ScanInitial());

  ScanResultModel? lastResult;

  void _emit(ScanState state) {
    if (!isClosed) emit(state);
  }

  Future<void> predict(File imageFile) async {
    _emit(ScanLoading());
    try {
      final result = await _repo.predict(imageFile);
      lastResult = result;
      _emit(ScanSuccess(result));
    } on Failer catch (e) {
      _emit(ScanError(e.errorMessage));
    } catch (e) {
      _emit(ScanError('Something went wrong'));
    }
  }

  Future<void> getHistory() async {
    _emit(ScanLoading());
    try {
      final history = await _repo.getHistory();
      _emit(HistoryLoaded(history));
    } on Failer catch (e) {
      _emit(ScanError(e.errorMessage));
    } catch (e) {
      _emit(ScanError('Something went wrong'));
    }
  }

  Future<void> getHistoryWithStatus(String status) async {
    _emit(ScanLoading());
    try {
      final history = await _repo.getHistoryWithStatus(status);
      _emit(HistoryLoaded(history));
    } on Failer catch (e) {
      _emit(ScanError(e.errorMessage));
    } catch (e) {
      _emit(ScanError('Something went wrong'));
    }
  }

  Future<void> getStatistics() async {
    _emit(ScanLoading());
    try {
      final statistics = await _repo.getStatistics();
      _emit(StatisticsLoaded(statistics));
    } on Failer catch (e) {
      _emit(ScanError(e.errorMessage));
    } catch (e) {
      _emit(ScanError('Something went wrong'));
    }
  }
}