import 'package:flutter/material.dart';
import 'home_app_bar.dart';
import 'home_ai_card.dart';
import 'home_services_grid.dart';
import 'home_tip_card.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: const [
          HomeAppBar(),
          SizedBox(height: 20),
          HomeAiCard(),
          SizedBox(height: 24),
          HomeServicesGrid(),
          SizedBox(height: 16),
          HomeTipCard(),
        ],
      ),
    );
  }
}
