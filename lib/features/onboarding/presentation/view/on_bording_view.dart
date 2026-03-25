import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sakeena_app/core/utils/app_router.dart';
import 'package:sakeena_app/core/widgets/coustem_eleveted_butten.dart';
import 'package:sakeena_app/features/onboarding/presentation/view/widgets/on_bording_view_body.dart';
import 'package:sakeena_app/features/onboarding/presentation/view_model/on_bording_model.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  final PageController controller = PageController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEEDFCC),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Column(
              children: [
                Expanded(
                  child: OnBoardingBody(
                    controller: controller,
                    onPageChanged: (index) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                    currentIndex: currentIndex,
                    data: onBoardingList,
                  ),
                ),

                // /// 🔹 Button
                // SizedBox(
                //   width: double.infinity,
                //   height: 50,
                //   child: ElevatedButton(
                //     onPressed: () {
                //       if (currentIndex == onBoardingList.length - 1) {
                //         // finish
                //       } else {
                //         controller.nextPage(
                //           duration: const Duration(milliseconds: 300),
                //           curve: Curves.easeInOut,
                //         );
                //       }
                //     },
                //     child: Text(
                //       currentIndex == onBoardingList.length - 1
                //           ? 'ابدأ'
                //           : 'التالي',
                //     ),
                //   ),
                // ),
                CoustemElevetedBoutten(
                  text: currentIndex == onBoardingList.length - 1
                      ? 'ابدأ'
                      : 'التالي',
                  onPressed: () {
                    if (currentIndex == onBoardingList.length - 1) {
                      context.go(AppRouter.kwellComView);
                    } else {
                      controller.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  height: 50,
                  backgroundcolor: Color(0xffA53860),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
