import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'home_app_bar.dart';
import 'home_ai_card.dart';
import 'home_services_grid.dart';
import 'home_tip_card.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
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
