import 'package:flutter/material.dart';
import 'package:sakeena_app/core/resources/app_colors.dart';
import 'package:sakeena_app/features/auth/presentation/view/widgets/sin_up_view_body.dart';

class SinUpView extends StatelessWidget {
  const SinUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(child: SinUpViewBody()),
      backgroundColor: AppColors.KprimaryColor,
    );
  }
}
