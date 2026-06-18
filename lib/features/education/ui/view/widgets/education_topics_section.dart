import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sakeena_app/core/resources/app_colors.dart';
import 'package:sakeena_app/core/utils/app_router.dart';

class EducationTopicsSection extends StatelessWidget {
  const EducationTopicsSection({super.key});

  
   static final topics = [
  _TopicData(
    route: AppRouter.kAssessmentView,
    title: 'دليل الفحص الذاتي',
    subtitle: 'تعلمي كيفية إجراء الفحص الذاتي للثدي بشكل صحيح',
    icon: Icons.back_hand_outlined,
    color: Color(0xFFE8F5E9),
    borderColor: Color(0xFF4CAF50),
    iconColor: Color(0xFF4CAF50),
  ),

  _TopicData(
    route: AppRouter.kWarningSignsScreen,
    title: 'علامات التحذير',
    subtitle: 'تعرفي على العلامات التي يجب الانتباه إليها',
    icon: Icons.remove_red_eye_outlined,
    color: Color(0xFFFFF8E1),
    borderColor: Color(0xFFFFB300),
    iconColor: Color(0xFFFFB300),
  ),

  _TopicData(
    route: AppRouter.kSelfExamGuideScreen,
    title: 'الوقاية والتوعية',
    subtitle: 'نصائح للحفاظ على صحة الثدي وتقليل المخاطر',
    icon: Icons.menu_book_outlined,
    color: Color(0xFFFCF4F7),
    borderColor: Color(0xFFC72063),
    iconColor: Color(0xFFC72063),
  ),
];
  

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'المواضيع الرئيسية',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.textDark,
            fontFamily: 'Rubik',
          ),
        ),
        SizedBox(height: 12.h),
        ...topics.map((t) => _TopicCard(data: t)),
      ],
    );
  }
}

class _TopicCard extends StatelessWidget {
  const _TopicCard({required this.data});
  final _TopicData data;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: data.route != null ? () => context.push(data.route!) : null,
      child: Container(
        margin: EdgeInsets.only(bottom: 10.h),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppColors.border, width: 1.w),
        ),
        child: Row(
          children: [
                        Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: data.color,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: data.borderColor.withOpacity(0.3),
                  width: 1.2.w,
                ),
              ),
              child: Icon(data.icon, size: 22.sp, color: data.iconColor),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.title,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textDark,
                      fontFamily: 'Rubik',
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    data.subtitle,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.textSecondary,
                      fontFamily: 'Rubik',
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            

          ],
        ),
      ),
    );
  }
}

class _TopicData {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final Color borderColor;
  final Color iconColor;
  final String? route;

  const _TopicData({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.borderColor,
    required this.iconColor,
    required this.route,
  });
}
