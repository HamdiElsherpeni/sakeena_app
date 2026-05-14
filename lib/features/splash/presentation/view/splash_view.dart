import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sakeena_app/constsnt.dart';
import 'package:sakeena_app/core/resources/app_assets.dart';
import 'package:sakeena_app/core/services/token_service.dart';
import 'package:sakeena_app/core/utils/app_router.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  Future<void> _navigate() async {
    await Future.delayed(kTranstionDuration);

    final seenOnboarding = await TokenService.hasSeenOnboarding();
    final isLoggedIn = await TokenService.hasToken();
    debugPrint('isLoggedIn: $isLoggedIn');
    if (!mounted) return;

    final router = GoRouter.of(context);
    if (!seenOnboarding) {
      // أول مرة يفتح التطبيق → الـ Onboarding
      router.go(AppRouter.konBording);
    } else if (isLoggedIn) {
      // شاف الـ Onboarding وعنده token → الـ Home
      router.go(AppRouter.khomeView);
    } else {
      // شاف الـ Onboarding بس مش logged in → Welcome
      router.go(AppRouter.kwellComView);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SizedBox(height: 200.h, child: Image.asset(AppAssets.logo)),
        ),
      ),
    );
  }
}
