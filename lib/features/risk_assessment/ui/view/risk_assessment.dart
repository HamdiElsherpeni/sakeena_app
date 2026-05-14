import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakeena_app/core/di/service_locator.dart';
import 'package:sakeena_app/core/resources/app_colors.dart';
import 'package:sakeena_app/features/risk_assessment/data/repositories/risk_assessment_repository.dart';
import 'package:sakeena_app/features/risk_assessment/logic/cubit/risk_assessment_cubit.dart';
import 'package:sakeena_app/features/risk_assessment/ui/view/widgets/risk_assessment_body.dart';

class AssessmentScreen extends StatelessWidget {
  const AssessmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RiskAssessmentCubit(getIt<RiskAssessmentRepository>()),
      child: Scaffold(
        backgroundColor: AppColors.skipBg,
        body: const AssessmentScreenBody(),
      ),
    );
  }
}
