import 'package:flutter/material.dart';
import 'package:sakeena_app/core/resources/app_colors.dart';
import 'exam_history_header.dart';
import 'exam_filter_sort_row.dart';
import 'exam_list.dart';

class ExamHistoryViewBody extends StatelessWidget {
  const ExamHistoryViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.kprimaryColor,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const [
              ExamHistoryHeader(),
              ExamFilterSortRow(),
              Expanded(child: ExamList()),
            ],
          ),
        ),
      ),
    );
  }
}
