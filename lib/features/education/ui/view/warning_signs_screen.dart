import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sakeena_app/core/resources/app_colors.dart';
import 'package:sakeena_app/features/education/ui/view/widgets/warning_sign_card.dart';

class WarningSignsScreen extends StatelessWidget {
  const WarningSignsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.kprimaryColor,
        body: SafeArea(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 14.h,
                ),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15.r),
                    bottomRight: Radius.circular(15.r),
                  ),
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => context.pop(),
                      child: Container(
                        width: 36.w,
                        height: 36.w,
                        decoration: BoxDecoration(
                          color: AppColors.kprimaryColor,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: AppColors.primary,
                          size: 16.sp,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'علامات التحذير',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                          fontFamily: 'Rubik',
                        ),
                      ),
                    ),
                    SizedBox(width: 36.w),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    children: const [
                      WarningSignCard(
                        title: 'وجود كتلة أو ورم',
                        description:
                            'ظهور كتلة جديدة في الثدي أو تحت الإبط قد يكون علامة تستدعي الفحص الطبي.',
                        icon: Icons.warning_amber_rounded,
                      ),
                      WarningSignCard(
                        title: 'تغير شكل الثدي',
                        description:
                            'أي تغير ملحوظ في حجم أو شكل الثدي يحتاج إلى متابعة.',
                        icon: Icons.change_circle_outlined,
                      ),
                      WarningSignCard(
                        title: 'إفرازات غير طبيعية',
                        description:
                            'خروج إفرازات من الحلمة خاصة إذا كانت دموية يستدعي استشارة الطبيب.',
                        icon: Icons.opacity_outlined,
                      ),
                      WarningSignCard(
                        title: 'تغيرات الجلد',
                        description:
                            'مثل التجعد أو الاحمرار أو سماكة الجلد بشكل غير طبيعي.',
                        icon: Icons.health_and_safety_outlined,
                      ),
                      WarningSignCard(
                        title: 'انكماش الحلمة',
                        description:
                            'دخول الحلمة للداخل أو تغير اتجاهها بشكل مفاجئ.',
                        icon: Icons.radio_button_checked_outlined,
                      ),
                      WarningSignCard(
                        title: 'ألم مستمر',
                        description:
                            'الألم المستمر في منطقة محددة من الثدي يستوجب الفحص.',
                        icon: Icons.sick_outlined,
                      ),
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