import 'package:flutter/material.dart';
import 'package:sakeena_app/constsnt.dart';
import 'package:sakeena_app/core/resources/app_colors.dart';
import 'package:sakeena_app/features/onboarding/presentation/view/widgets/well_come_view_body.dart';

class WellComeView extends StatelessWidget {
  const WellComeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container( decoration: const BoxDecoration(
        gradient: LinearGradient(
    colors: [
      Color(0xffFFFFFF),
      Color(0xffF5EFE7),
      AppColors.skipBg,
    ],
    stops: [0.0, 0.6, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  ),
      ),
      child: SafeArea(child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kPaading),
          child: WellComeViewBody(),
        )),
      ));
  }
}
