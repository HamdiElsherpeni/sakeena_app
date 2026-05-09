import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sakeena_app/core/resources/app_colors.dart';
import 'widgets/education_header.dart';
import 'widgets/education_topics_section.dart';
import 'widgets/education_articles_section.dart';
import 'widgets/education_did_you_know_banner.dart';

class EducationScreen extends StatelessWidget {
  const EducationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.kprimaryColor,
        body: SafeArea(
          child: Column(
            children: [
              EducationHeader(),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 8.h),
                      EducationTopicsSection(),
                      SizedBox(height: 24.h),
                      EducationArticlesSection(),
                      SizedBox(height: 24.h),
                      EducationDidYouKnowBanner(),
                      SizedBox(height: 16.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
