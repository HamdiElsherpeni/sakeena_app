import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakeena_app/core/resources/app_colors.dart';
import 'package:sakeena_app/features/exam_history/data/models/prediction_history_model.dart';
import 'package:sakeena_app/features/exam_history/logic/cubit/prediction_history_cubit.dart';
import 'package:sakeena_app/features/exam_history/ui/widgets/exam_card.dart';
import 'package:sakeena_app/features/exam_history/ui/widgets/exam_status_badge.dart';
import 'package:sakeena_app/features/exam_history/ui/widgets/sort_filter_bar.dart'
    show SortFilterBar;

class ExamHistoryViewBody extends StatelessWidget {
  const ExamHistoryViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kprimaryColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _Header(),
            _FilterSortRow(),
            const Expanded(child: _ExamList()),
          ],
        ),
      ),
    );
  }
}

// ─── Header ──────────────────────────────────────────────────────────────────

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 4.h),
      child: Column(
        children: [
          Text(
            'سجل الفحوصات',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.textDark,
              fontFamily: 'Rubik',
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            'جميع الفحوصات السابقة',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13.sp,
              color: AppColors.textSecondary,
              fontFamily: 'Rubik',
            ),
          ),
          SizedBox(height: 8.h),
        ],
      ),
    );
  }
}

// ─── Filter + Sort Row ────────────────────────────────────────────────────────

class _FilterSortRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PredictionHistoryCubit, PredictionHistoryState>(
      buildWhen: (prev, curr) =>
          curr is PredictionHistorySuccess || curr is PredictionHistoryLoading,
      builder: (context, state) {
        final activeFilter = _extractActiveFilter(state);
        final sortAscending = _extractSortAscending(state);

        return SortFilterBar(
          activeFilter: activeFilter,
          sortAscending: sortAscending,
          onSortToggle: () =>
              context.read<PredictionHistoryCubit>().toggleSort(),
          onFilterChanged: (filter) =>
              context.read<PredictionHistoryCubit>().filterByStatus(filter),
        );
      },
    );
  }

  String _extractActiveFilter(PredictionHistoryState state) {
    if (state is PredictionHistorySuccess) return state.activeFilter;
    return 'all';
  }

  bool _extractSortAscending(PredictionHistoryState state) {
    if (state is PredictionHistorySuccess) return state.sortAscending;
    return false;
  }
}

// ─── Exam List ────────────────────────────────────────────────────────────────

class _ExamList extends StatelessWidget {
  const _ExamList();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PredictionHistoryCubit, PredictionHistoryState>(
      builder: (context, state) {
        if (state is PredictionHistoryLoading) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        }

        if (state is PredictionHistoryFailure) {
          return _ErrorState(
            message: state.message,
            onRetry: () => context.read<PredictionHistoryCubit>().loadHistory(),
          );
        }

        final exams = _extractExams(state);
        final loadingId = _extractLoadingId(state);

        if (exams == null || exams.isEmpty) {
          return const _EmptyState();
        }

        return RefreshIndicator(
          color: AppColors.primary,
          onRefresh: () => context.read<PredictionHistoryCubit>().loadHistory(),
          child: ListView.builder(
            padding: EdgeInsets.only(bottom: 20.h),
            itemCount: exams.length,
            itemBuilder: (context, index) {
              final exam = exams[index];
              return ExamCard(
                date: exam.formattedDate,
                status: _mapStatus(exam.predictionStatus),
                riskLabel: exam.predictionStatus.riskLabel,
                isDownloadLoading: loadingId == exam.id,
                onDownload: loadingId != null
                    ? null // مش هيضغط على كارت تاني وقت التحميل
                    : () => context
                          .read<PredictionHistoryCubit>()
                          .downloadReport(exam.id),
              );
            },
          ),
        );
      },
    );
  }

  List<PredictionHistoryModel>? _extractExams(PredictionHistoryState state) {
    if (state is PredictionHistorySuccess) return state.exams;
    if (state is PredictionReportLoading) return state.exams;
    if (state is PredictionReportSuccess) return state.exams;
    if (state is PredictionReportFailure) return state.exams;
    return null;
  }

  int? _extractLoadingId(PredictionHistoryState state) {
    if (state is PredictionReportLoading) return state.predictionId;
    return null;
  }

  ExamStatus _mapStatus(PredictionStatus status) {
    switch (status) {
      case PredictionStatus.benign:
        return ExamStatus.safe;
      case PredictionStatus.malignant:
        return ExamStatus.danger;
      case PredictionStatus.unknown:
        return ExamStatus.moderate;
    }
  }
}

// ─── Empty State ─────────────────────────────────────────────────────────────

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.folder_open_outlined,
            size: 56.sp,
            color: AppColors.textSecondary,
          ),
          SizedBox(height: 12.h),
          Text(
            'لا توجد فحوصات سابقة',
            style: TextStyle(
              fontSize: 15.sp,
              color: AppColors.textSecondary,
              fontFamily: 'Rubik',
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Error State ─────────────────────────────────────────────────────────────

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: 52.sp,
              color: AppColors.primary,
            ),
            SizedBox(height: 12.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.textDark,
                fontFamily: 'Rubik',
              ),
            ),
            SizedBox(height: 16.h),
            TextButton(
              onPressed: onRetry,
              child: Text(
                'إعادة المحاولة',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.primary,
                  fontFamily: 'Rubik',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
