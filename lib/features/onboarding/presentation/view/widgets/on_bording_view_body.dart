import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakeena_app/core/resources/app_colors.dart';
import 'package:sakeena_app/features/onboarding/presentation/view_model/on_bording_model.dart';

class OnBoardingBody extends StatelessWidget {
  final PageController controller;
  final Function(int) onPageChanged;
  final int currentIndex;
  final List<OnBoardingModel> data;

  /// callback لما يخلص onboarding
  final VoidCallback onFinish;

  const OnBoardingBody({
    super.key,
    required this.controller,
    required this.onPageChanged,
    required this.currentIndex,
    required this.data,
    required this.onFinish,
  });

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
            /// Indicator
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

            /// Skip
            if (!isLastPage)
              Container(
                decoration: BoxDecoration(
                  color: AppColors.skipBg,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: TextButton(
                  onPressed: () {
                    controller.jumpToPage(data.length - 1);
                  },
                  child: Text(
                    'تخطي',
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: AppColors.skipText,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),

        SizedBox(height: 30.h),

        /// Pages
        Expanded(
          child: PageView.builder(
            controller: controller,
            itemCount: data.length,
            onPageChanged: onPageChanged,
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    data[index].image,
                    height: 310.h,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    data[index].title,
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    data[index].subTitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              );
            },
          ),
        ),

        /// ✅ زرار ابدأ (مرة واحدة بس)
      ],
    );
  }
}
