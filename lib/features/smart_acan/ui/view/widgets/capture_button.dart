import 'package:flutter/material.dart';
import 'package:sakeena_app/core/resources/app_colors.dart';

class CaptureButton extends StatelessWidget {
  final VoidCallback? onPressed;
  const CaptureButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 18),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 0,
      ),
      icon: Container(
        width: 35,
        height: 35,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: const Icon(
          color: AppColors.primary,
          Icons.camera_alt_outlined,
          size: 22,
        ),
      ),
      label: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'إلتقاط صورة',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              fontFamily: 'Cairo',
            ),
          ),
          Text(
            'التقطي صورة مباشرة للأشعة',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              fontFamily: 'Cairo',
            ),
          ),
        ],
      ),
    );
  }
}
