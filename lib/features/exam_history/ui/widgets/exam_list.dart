import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sakeena_app/core/resources/app_colors.dart';
import 'package:sakeena_app/core/utils/app_router.dart';
import 'package:sakeena_app/features/exam_history/data/models/prediction_history_model.dart';
import 'package:sakeena_app/features/exam_history/logic/cubit/prediction_history_cubit.dart';
import 'package:sakeena_app/features/exam_history/ui/widgets/exam_card.dart';
import 'package:sakeena_app/features/exam_history/ui/widgets/exam_status_badge.dart';
import 'exam_empty_state.dart';
import 'exam_error_state.dart';

class ExamList extends StatelessWidget {
  const ExamList({super.key});

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
          return ExamErrorState(
            message: state.message,
            onRetry: () => context.read<PredictionHistoryCubit>().loadHistory(),
          );
        }

        final exams = _extractExams(state);

        if (exams == null || exams.isEmpty) {
          return const ExamEmptyState();
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
                onView: () =>
                    context.push(AppRouter.kExamReportScreen, extra: exam),
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
