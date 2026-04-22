import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakeena_app/core/resources/app_colors.dart';
import 'package:sakeena_app/core/widgets/custom_nav_bar.dart';
import 'package:sakeena_app/features/smart_acan/ui/view/widgets/smart_scan_view_body.dart';

class SmartScanScreen extends StatelessWidget {
  const SmartScanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kprimaryColor,
      bottomNavigationBar: CustomNavBar(currentIndex: 2),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: SmartScanViewBody(),
        ),
      ),
    );
  }
}
