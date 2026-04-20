import 'package:flutter/material.dart';
import 'package:sakeena_app/core/resources/app_colors.dart';
import 'widgets/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.KprimaryColor,
      body: SafeArea(child: HomeViewBody()),
    );
  }
}
