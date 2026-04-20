import 'package:flutter/material.dart';
import 'package:sakeena_app/core/resources/app_colors.dart';
import 'package:sakeena_app/features/profile_view/presentation/view/widgets/change_poassword_view_body.dart';

class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.KprimaryColor,
      body: SafeArea(child: ChangePasswordViewBody()),
    );
  }
}
