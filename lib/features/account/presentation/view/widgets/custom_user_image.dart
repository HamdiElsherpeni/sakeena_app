import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakeena_app/core/resources/app_assets.dart';
import 'package:sakeena_app/core/resources/app_colors.dart';

class CustomUserImage extends StatelessWidget {
  CustomUserImage({super.key, this.onTap});
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        CircleAvatar(
          radius: 50.r,
          backgroundColor: AppColors.primary,

          child: CircleAvatar(
            radius: 46.r,
            backgroundColor: AppColors.kprimaryColor,
            backgroundImage: AssetImage(
              AppAssets.test, // placeholder
            ),
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 28.w,
            height: 28.h,
            decoration: BoxDecoration(
              color: Color(0xFFB5456A),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2.w),
            ),
            child: Icon(Icons.edit, color: Colors.white, size: 14),
          ),
        ),
      ],
    );
  }
}
