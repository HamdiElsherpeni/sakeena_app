import 'package:flutter/material.dart';
import 'package:sakeena_app/core/resources/app_colors.dart';
import 'package:sakeena_app/features/risk_assessment/ui/view/widgets/risk_assessment_body.dart';

class AssessmentScreen extends StatelessWidget {
  const AssessmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AssessmentScreenBody(),
      backgroundColor: AppColors.skipBg,
    );
  }
}
