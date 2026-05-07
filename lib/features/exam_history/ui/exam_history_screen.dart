import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakeena_app/core/widgets/snack_bar_helper.dart';
import 'package:sakeena_app/features/exam_history/logic/cubit/prediction_history_cubit.dart';
import 'package:sakeena_app/features/exam_history/ui/widgets/exam_history_view_body.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:sakeena_app/features/exam_history/data/repos/prediction_history_repo.dart';

class ExamHistoryScreen extends StatelessWidget {
  const ExamHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          PredictionHistoryCubit(const PredictionHistoryRepoImpl())
            ..loadHistory(),
      child: BlocListener<PredictionHistoryCubit, PredictionHistoryState>(
        listener: _handleListener,
        child: const ExamHistoryViewBody(),
      ),
    );
  }

  void _handleListener(BuildContext context, PredictionHistoryState state) {
    if (state is PredictionReportSuccess) {
      _openReport(context, state.reportUrl);
    }
    if (state is PredictionReportFailure) {
      SnackBarHelper.showError(context, message: state.message);
    }
    if (state is PredictionHistoryFailure) {
      SnackBarHelper.showError(context, message: state.message);
    }
  }

  // ✅ Fix 1: canLaunchUrl من url_launcher — موجودة كـ top-level function مش method
  // ✅ Fix 2: نحفظ الـ ScaffoldMessenger قبل الـ await عشان نتجنب async context warning
  Future<void> _openReport(BuildContext context, String url) async {
    final messenger = ScaffoldMessenger.of(context); // ✅ save before await

    if (url.isEmpty) {
      SnackBarHelper.showErrorWithMessenger(
        messenger,
        message: 'رابط التقرير غير متاح.',
      );
      return;
    }

    final uri = Uri.tryParse(url);
    if (uri == null) {
      SnackBarHelper.showErrorWithMessenger(
        messenger,
        message: 'رابط التقرير غير صالح.',
      );
      return;
    }

    final canLaunch = await canLaunchUrl(
      uri,
    ); // ✅ top-level function من url_launcher
    if (!canLaunch) {
      SnackBarHelper.showErrorWithMessenger(
        messenger,
        message: 'تعذّر فتح التقرير.',
      );
      return;
    }

    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}
