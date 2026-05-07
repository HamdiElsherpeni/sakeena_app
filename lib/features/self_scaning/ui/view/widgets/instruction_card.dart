import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakeena_app/core/resources/app_colors.dart';

class InstructionCard extends StatelessWidget {
  final String instruction;

  const InstructionCard({super.key, required this.instruction});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 239, 209, 165).withOpacity(0.35),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.skipText, width: 1),
      ),
      child: Text(
        instruction,
        textAlign: TextAlign.right,
        style: TextStyle(
          fontSize: 15.sp,
          fontWeight: FontWeight.w600,
          height: 1.7,
          color: AppColors.primary,
        ),
      ),
    );
  }
}
