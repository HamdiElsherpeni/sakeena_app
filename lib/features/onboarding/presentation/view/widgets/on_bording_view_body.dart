import 'package:flutter/material.dart';
import 'package:sakeena_app/core/resources/app_colors.dart';
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

  @override
  Widget build(BuildContext context) {
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
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  height: 9,
                  width: currentIndex == index ? 30 : 15,
                  decoration: BoxDecoration(
                    color: currentIndex == index
                        ? AppColors.primary
                        : AppColors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),

            /// 🔸 Skip Button
            Container(
              decoration: BoxDecoration(
                color: AppColors.skipBg,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextButton(
                onPressed: () {
                  controller.jumpToPage(data.length - 1);
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 6,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  'تخطي',
                  style: TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: 20,
                    color: AppColors.skipText,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 30),

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
                    height: 310,
                    child: Image.asset(data[index].image, fit: BoxFit.contain),
                  ),

                  const SizedBox(height: 10),

                  /// 🔸 Title
                  Text(
                    data[index].title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                

                  /// 🔸 Subtitle
                  Text(
                    data[index].subTitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontFamily: 'Rubik',
                    ),
                  ),
                    const SizedBox(height: 10),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
