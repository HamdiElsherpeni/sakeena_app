import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sakeena_app/core/resources/app_assets.dart';
import 'package:sakeena_app/core/resources/app_colors.dart';
import 'package:sakeena_app/core/utils/app_router.dart';
import 'package:sakeena_app/core/widgets/coustem_eleveted_butten.dart';

class WellComeViewBody extends StatelessWidget {
  const WellComeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 150,
          child: Center(child: Image.asset(AppAssets.logo, fit: BoxFit.cover)),
        ),
        Text(
          'اهلا بك في سكينة',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        Text(
          'ابدئي رحلتك بالوعي واهتمي بنفسك',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 40),
        CoustemElevetedBoutten(
          height: 60,
          onPressed: () {
            GoRouter.of(context).push(AppRouter.kLogin);
          },
          text: 'سجلي  الدخول',
          backgroundcolor: AppColors.primary,
        ),
        SizedBox(height: 20),

        CoustemElevetedBoutten(
          height: 60,
          onPressed: () {
           GoRouter.of(context).push(AppRouter.ksinupView);
          },
          text: 'انشئي حساب جديد',
          backgroundcolor: Colors.transparent,
          textcolor: Colors.black,
        ),
      ],
    );
  }
}
