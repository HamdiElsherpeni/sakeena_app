import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sakeena_app/core/resources/app_colors.dart';
import 'package:sakeena_app/core/utils/app_router.dart';
import 'package:sakeena_app/features/home/presentation/view/widgets/home_services_item.dart';

class HomeServicesGrid extends StatelessWidget {
  const HomeServicesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'الخدمات الاساسية',
          textDirection: TextDirection.rtl,
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 17, 17, 17),
          ),
        ),
        SizedBox(height: 14.h),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.1,
          children: [
            HomeServiceItem(
              title: 'الفحص الذكي',
              subtitle: 'تحليل الأشعة لتحديد نوع الورم',
              icon: Icons.crop_free,
              backgroundColor: AppColors.noticeBorder,
              iconColor: Color(0xFF7E57C2),
              onTap: () {
                context.push(AppRouter.kSmartAcanView);
              },
            ),
            HomeServiceItem(
              title: 'اختبار الاطمئنان',
              subtitle: 'اختبار سريع لتقييم مبدئي لصحتك',
              icon: Icons.assignment_outlined,
              backgroundColor: Color(0xFFF3E5F5),
              iconColor: Color(0xFFAB47BC),
              onTap: () {
                context.push(AppRouter.kAssessmentView);
              },
            ),
            HomeServiceItem(
              title: 'دليلك الصحي',
              subtitle: 'معلومات مفيدة لصحتك',
              icon: Icons.open_in_new,
              backgroundColor: Color(0xFFE3F2FD),
              iconColor: Color(0xFF42A5F5),
               onTap: () {
                context.push(AppRouter.khealthguid);
              },
            ),
            HomeServiceItem(
              title: 'فحص ذاتي',
              subtitle: 'تعلمي كيفية الفحص الذاتي بسهولة',
              icon: Icons.favorite_outline,
              backgroundColor: AppColors.noticeBorder,
              iconColor: Color(0xFFEC407A),
              onTap: () {
                context.push(AppRouter.kSelfExamGuideScreen);
              },
            ),
          ],
        ),
      ],
    );
  }
}
