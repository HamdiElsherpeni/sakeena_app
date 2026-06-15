import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakeena_app/core/resources/app_colors.dart';

class GuideSearchBarWidget extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const GuideSearchBarWidget({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.h,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.border, width: 1.w),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        textDirection: TextDirection.rtl,
        onChanged: onChanged,
        style: TextStyle(fontSize: 13.sp, color: AppColors.textDark),
        decoration: InputDecoration(
          hintText: 'ابحثي عن معلومة صحية...',
          hintStyle: TextStyle(
            fontSize: 13.sp,
            color: AppColors.textLight,
          ),
          hintTextDirection: TextDirection.rtl,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 13.h),
          prefixIcon: Icon(
            Icons.search,
            color: AppColors.textLight,
            size: 20.sp,
          ),
        ),
      ),
    );
  }
}