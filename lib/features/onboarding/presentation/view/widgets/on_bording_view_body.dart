import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sakeena_app/core/database/my_cache_helper.dart';
import 'package:sakeena_app/core/database/prefs_constants.dart';
import 'package:sakeena_app/core/resources/app_colors.dart';
import 'package:sakeena_app/core/utils/app_router.dart';
import 'package:sakeena_app/features/onboarding/presentation/view_model/on_bording_model.dart';

class OnBoardingBody extends StatelessWidget {
  final PageController controller;
  final Function(int) onPageChanged;
  final int currentIndex;
  final List<OnBoardingModel> data;

  const OnBoardingBody({
    super.key,
    required this.controller,
    required this.onPageChanged,
    required this.currentIndex,
    required this.data,
  });

  /// ✅ فقط حفظ حالة الـ onboarding (بدون navigation هنا)
  Future<void> _finishOnBoarding() async {
    await SharedPrefHelper.setData(PrefsConstants.onBoarding, true);
  }

  @override
  Widget build(BuildContext context) {
    final bool isLastPage = currentIndex == data.length - 1;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        /// 🔹 Indicator + Skip
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /// 🔸 Indicator
            Row(
              children: List.generate(
                data.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                  height: 9.h,
                  width: currentIndex == index ? 30 : 15,
                  decoration: BoxDecoration(
                    color: currentIndex == index
                        ? AppColors.primary
                        : AppColors.grey,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
              ),
            ),

            /// 🔸 Skip Button
            if (!isLastPage)
              Container(
                decoration: BoxDecoration(
                  color: AppColors.skipBg,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: TextButton(
                  onPressed: () async {
                    await _finishOnBoarding();

                    if (context.mounted) {
                      context.go(AppRouter.kwellComView); // 👈 نرجع للسplash
                    }
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 6,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                  ),
                  child: Text(
                    'تخطي',
                    style: TextStyle(
                      fontFamily: 'Rubik',
                      fontSize: 20.sp,
                      color: AppColors.skipText,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
          ],
        ),

        SizedBox(height: 30.h),

        /// 🔹 Pages
        Expanded(
          child: PageView.builder(
            controller: controller,
            itemCount: data.length,
            onPageChanged: onPageChanged,
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /// 🔸 Image
                  SizedBox(
                    height: 310.h,
                    child: Image.asset(data[index].image, fit: BoxFit.contain),
                  ),

                  SizedBox(height: 10.h),

                  /// 🔸 Title
                  Text(
                    data[index].title,
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  SizedBox(height: 10.h),

                  /// 🔸 Subtitle
                  Text(
                    data[index].subTitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey, fontFamily: 'Rubik'),
                  ),

                  SizedBox(height: 10.h),
                ],
              );
            },
          ),
        ),

        /// 🔹 زرار "ابدأ"
        if (isLastPage)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  await _finishOnBoarding();

                  if (context.mounted) {
                    context.go(AppRouter.kSplash); // 👈 أهم نقطة
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                ),
                child: Text(
                  'ابدأ',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontFamily: 'Rubik',
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
