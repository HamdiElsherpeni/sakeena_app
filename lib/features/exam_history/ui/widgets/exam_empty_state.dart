import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakeena_app/core/resources/app_colors.dart';

class ExamEmptyState extends StatelessWidget {
  const ExamEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.folder_open_outlined,
            size: 56.sp,
            color: AppColors.textSecondary,
          ),
          SizedBox(height: 12.h),
          Text(
            'لا توجد فحوصات سابقة',
            style: TextStyle(
              fontSize: 15.sp,
              color: AppColors.textSecondary,
              fontFamily: 'Rubik',
            ),
          ),
        ],
      ),
    );
  }
}
