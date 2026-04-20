import 'package:flutter/material.dart';
import 'package:sakeena_app/core/resources/app_colors.dart';

class HomeTipCard extends StatelessWidget {
  const HomeTipCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF0F4),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          const Expanded(
            child: Text(
              'الاكتشاف المبكر ينقذ الحياة قومي بالفحص الذاتي شهرياً وراجعي الطبيب سنوياً.',
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 13,
                color: Color(0xFF2D2D2D),
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.favorite,
              color: AppColors.primary,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}
