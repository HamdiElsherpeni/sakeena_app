import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakeena_app/core/resources/app_colors.dart';
import 'package:sakeena_app/features/health_guide/data/health_guide_data.dart';
import 'package:sakeena_app/features/health_guide/data/models/health_guide_models.dart';

class ArticleDetailScreen extends StatelessWidget {
  final HealthArticle article;

  const ArticleDetailScreen({super.key, required this.article});

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

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xffFAF5F7),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          automaticallyImplyLeading: false,
          actions: [
            Padding(
              padding: EdgeInsets.only(left: 16.w),
              child: CircleAvatar(
                radius: 21.r,
                backgroundColor: AppColors.border,
                child: CircleAvatar(
                  radius: 20.r,
                  backgroundColor: AppColors.kprimaryColor,
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      size: 16.sp,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
            ),
          ],
          title: Text(
            'دليلك الصحي',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.textDark,
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Category badge
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
                decoration: BoxDecoration(
                  color: AppColors.selectedBg,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  '$_categoryIcon  $_categoryTitle',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: 14.h),

              // Title
              Text(
                article.title,
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textDark,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 8.h),

              // Read time
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    article.readTime,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.textLight,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Icon(Icons.access_time, size: 14.sp, color: AppColors.textLight),
                ],
              ),
              SizedBox(height: 20.h),

              // Divider
              Divider(color: AppColors.border, thickness: 1.h),
              SizedBox(height: 20.h),

              // Content
              Text(
                article.content,
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 15.sp,
                  color: AppColors.textDark,
                  height: 1.9,
                ),
              ),
              SizedBox(height: 30.h),

              // Notice card
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: const Color(0xffFFFBEB),
                  borderRadius: BorderRadius.circular(14.r),
                  border: Border.all(
                    color: AppColors.noticeBorder,
                    width: 1.w,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'تنبيه مهم',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textDark,
                          ),
                        ),
                        SizedBox(width: 6.w),
                        const Text('⚠️'),
                      ],
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      'هذه المعلومات لأغراض توعوية فقط ولا تُغني عن استشارة الطبيب المختص.',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.textSecondary,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}