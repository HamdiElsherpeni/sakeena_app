import 'package:flutter/material.dart';
import 'package:sakeena_app/core/resources/app_colors.dart';

class UploadCard extends StatelessWidget {
  final VoidCallback? onTap;
  const UploadCard({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 36),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 72,
              height: 200,
              decoration: BoxDecoration(
                color: AppColors.skipBg,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.upload_rounded,
                size: 34,
                color: AppColors.skipText,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'رفع صورة طبية',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
                fontFamily: 'Cairo',
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'اختاري صورة من معرض الصور أو التقطي صورة جديدة',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey[500],
                fontFamily: 'Cairo',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
