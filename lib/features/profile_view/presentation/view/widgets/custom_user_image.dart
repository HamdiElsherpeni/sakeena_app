import 'package:flutter/material.dart';
import 'package:sakeena_app/core/resources/app_assets.dart';
import 'package:sakeena_app/core/resources/app_colors.dart';

class CustomUserImage extends StatelessWidget {
  const CustomUserImage({super.key, this.onTap});
final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return  Stack(
          alignment: Alignment.bottomRight,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: AppColors.primary,
              
              child: CircleAvatar(
                radius: 46,
                backgroundColor: AppColors.KprimaryColor,
                backgroundImage:  AssetImage(
                  AppAssets.test,// placeholder
                ),
              ),
            ),
            GestureDetector(
              onTap: onTap ,
              child: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: const Color(0xFFB5456A),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: const Icon(Icons.edit, color: Colors.white, size: 14),
              ),
            ),
          ],
        );
  }
}