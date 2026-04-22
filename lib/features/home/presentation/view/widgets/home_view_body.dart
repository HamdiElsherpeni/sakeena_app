import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'home_app_bar.dart';
import 'home_ai_card.dart';
import 'home_services_grid.dart';
import 'home_tip_card.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          HomeAppBar(),
          SizedBox(height: 20.h),
          HomeAiCard(),
          SizedBox(height: 24.h),
          HomeServicesGrid(),
          SizedBox(height: 16.h),
          HomeTipCard(),
        ],
      ),
    );
  }
}
