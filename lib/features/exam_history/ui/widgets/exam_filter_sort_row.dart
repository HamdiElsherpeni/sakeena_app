import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakeena_app/features/exam_history/logic/cubit/prediction_history_cubit.dart';
import 'package:sakeena_app/features/exam_history/ui/widgets/sort_filter_bar.dart'
    show SortFilterBar;

class ExamFilterSortRow extends StatelessWidget {
  const ExamFilterSortRow({super.key});

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
