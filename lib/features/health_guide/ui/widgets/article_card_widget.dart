import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakeena_app/core/resources/app_colors.dart';
import '../../data/models/health_guide_models.dart';
import '../../data/health_guide_data.dart';

class ArticleCardWidget extends StatelessWidget {
  final HealthArticle article;
  final VoidCallback onTap;

  const ArticleCardWidget({
    super.key,
    required this.article,
    required this.onTap,
  });

  String get _categoryIcon {
    final cat = HealthGuideData.categories
        .where((c) => c.id == article.categoryId)
        .firstOrNull;
    return cat?.icon ?? '📄';
  }

  String get _categoryTitle {
    final cat = HealthGuideData.categories
        .where((c) => c.id == article.categoryId)
        .firstOrNull;
    return cat?.title ?? '';
  }

  Color get _categoryBg {
    final cat = HealthGuideData.categories
        .where((c) => c.id == article.categoryId)
        .firstOrNull;
    switch (cat?.color) {
      case 'green':
        return const Color(0xffE8F5E9);
      case 'blue':
        return const Color(0xffE3F2FD);
      case 'yellow':
        return const Color(0xffFFFDE7);
      case 'purple':
        return const Color(0xffF3E5F5);
      case 'orange':
        return const Color(0xffFFF3E0);
      default:
        return AppColors.selectedBg;
    }
  }

  Color get _categoryColor {
    final cat = HealthGuideData.categories
        .where((c) => c.id == article.categoryId)
        .firstOrNull;
    switch (cat?.color) {
      case 'green':
        return const Color(0xff2E7D32);
      case 'blue':
        return const Color(0xff1565C0);
      case 'yellow':
        return const Color(0xffF57F17);
      case 'purple':
        return const Color(0xff6A1B9A);
      case 'orange':
        return const Color(0xffE65100);
      default:
        return AppColors.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppColors.border, width: 1.w),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Arrow icon on the left
            Icon(
              Icons.arrow_back_ios,
              size: 14.sp,
              color: AppColors.textLight,
            ),
            const Spacer(),
            // Text content on the right
            Expanded(
              flex: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Category badge
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 3.h,
                        ),
                        decoration: BoxDecoration(
                          color: _categoryBg,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              _categoryTitle,
                              style: TextStyle(
                                fontSize: 10.sp,
                                color: _categoryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(width: 3.w),
                            Text(
                              _categoryIcon,
                              style: TextStyle(fontSize: 10.sp),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  // Title
                  Text(
                    article.title,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textDark,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  // Summary
                  Text(
                    article.summary,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  // Read time
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        article.readTime,
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: AppColors.textLight,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Icon(
                        Icons.access_time,
                        size: 12.sp,
                        color: AppColors.textLight,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 12.w),
            // Icon box on the far right
            Container(
              width: 52.w,
              height: 52.w,
              decoration: BoxDecoration(
                color: _categoryBg,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Center(
                child: Text(
                  _categoryIcon,
                  style: TextStyle(fontSize: 24.sp),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}