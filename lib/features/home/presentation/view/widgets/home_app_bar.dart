import 'package:flutter/material.dart';
import 'package:sakeena_app/core/resources/app_assets.dart';
import 'package:sakeena_app/core/resources/app_colors.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Settings icon
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(Icons.tune, color: AppColors.primary, size: 20),
        ),

        // Name + icon
        Row(
          children: [
            const Text(
              'أهلا,سارة محمد',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2D2D2D),
              ),
            ),
            const SizedBox(width: 8),
            Image.asset(AppAssets.logo, width: 35, height: 35),
          ],
        ),

        // Bell icon
        Stack(
          children: [
            const Icon(
              Icons.notifications_none,
              size: 28,
              color: Color(0xFF2D2D2D),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
