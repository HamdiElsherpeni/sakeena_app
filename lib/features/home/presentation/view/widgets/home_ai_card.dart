import 'package:flutter/material.dart';
import 'package:sakeena_app/core/resources/app_colors.dart';

class HomeAiCard extends StatelessWidget {
  const HomeAiCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // النص العلوي
          const Text(
            'انا سكينة،\nمساعدتك الشخصية بالAI',
            textAlign: TextAlign.right,
            style: TextStyle(color: Colors.white, fontSize: 20, height: 1.6),
          ),

          const SizedBox(height: 12),

          // زرار المحادثة
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: InkWell(
              onTap: () {},
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.arrow_back, color: AppColors.primary, size: 18),
                  SizedBox(width: 8),
                  Text(
                    '✨ ابدأي محادثتك...',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
