import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakeena_app/core/resources/app_colors.dart';
import 'package:sakeena_app/core/widgets/coustem_eleveted_butten.dart';

class ScanHistoryButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const ScanHistoryButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return CoustemElevetedBoutten(
      text: 'سجل الفحوصات',
      onPressed: onPressed,
      backgroundcolor: AppColors.white,
      textcolor: AppColors.primary,
      fontSize: 20.sp,
      height: 50.h,
    );
  }
}
