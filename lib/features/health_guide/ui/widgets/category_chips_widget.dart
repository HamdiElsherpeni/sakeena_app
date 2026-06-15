import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakeena_app/core/resources/app_colors.dart';
import '../../data/models/health_guide_models.dart';

class CategoryChipsWidget extends StatelessWidget {
  final List<HealthCategory> categories;
  final String selectedId;
  final ValueChanged<String> onSelected;

  const CategoryChipsWidget({
    super.key,
    required this.categories,
    required this.selectedId,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final all = [
      const HealthCategory(
          id: 'all', title: 'الكل', icon: '✨', color: 'pink'),
      ...categories,
    ];

    return SizedBox(
      height: 40.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        reverse: true,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        itemCount: all.length,
        separatorBuilder: (_, __) => SizedBox(width: 8.w),
        itemBuilder: (context, index) {
          final cat = all[index];
          final isSelected = cat.id == selectedId;

          return GestureDetector(
            onTap: () => onSelected(cat.id),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : AppColors.white,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: isSelected ? AppColors.primary : AppColors.border,
                  width: 1.w,
                ),
              ),
              child: Row(
                children: [
                  Text(cat.icon, style: TextStyle(fontSize: 13.sp)),
                  SizedBox(width: 4.w),
                  Text(
                    cat.title,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: isSelected
                          ? FontWeight.w700
                          : FontWeight.w400,
                      color:
                          isSelected ? AppColors.white : AppColors.textDark,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}