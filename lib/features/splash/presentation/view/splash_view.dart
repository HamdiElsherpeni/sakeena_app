import 'package:flutter/material.dart';
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

    if (!mounted) return;

    // 👇 لو لسه ما شافش onboarding
    if (!seenOnboarding) {
      context.go(AppRouter.konBording);
      return;
    }

    final isLoggedIn = await TokenService.hasToken();

    if (isLoggedIn) {
      context.go(AppRouter.khomeView);
    } else {
      context.go(AppRouter.kLogin); // 👈 مهم جدًا
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SizedBox(
            height: 200,
            child: Image.asset(AppAssets.logo),
          ),
        ),
      ),
    );
  }
}