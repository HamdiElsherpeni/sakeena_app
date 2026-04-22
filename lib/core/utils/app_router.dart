import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:sakeena_app/features/auth/presentation/view/forget_pass_view.dart';
import 'package:sakeena_app/features/auth/presentation/view/login_view.dart';
import 'package:sakeena_app/features/auth/presentation/view/sin_up_view.dart';
import 'package:sakeena_app/features/home/presentation/view/home_view.dart';
import 'package:sakeena_app/core/widgets/custom_nav_bar.dart';
import 'package:sakeena_app/features/onboarding/presentation/view/on_bording_view.dart';
import 'package:sakeena_app/features/onboarding/presentation/view/wellcome_view.dart';
import 'package:sakeena_app/features/account/presentation/view/change_password.dart';
import 'package:sakeena_app/features/account/presentation/view/profile_view.dart';
import 'package:sakeena_app/features/account/presentation/view/widgets/etide_profile_view.dart';
import 'package:sakeena_app/features/smart_acan/ui/view/smart_scan_screen.dart';
import 'package:sakeena_app/features/splash/presentation/view/splash_view.dart';

abstract class AppRouter {
  static String konBording = '/onbording';
  static String kwellComView = '/wellcomview';
  static String kLogin = '/login';
  static String ksinupView = '/SinupView';
  static String kforgetView = '/forgetview';
  static String khomeView = '/homeview';
  static String kprofileview = '/profileview';
  static String kprofileditview = '/profileditview';
  static String kSplash = '/';
  static String kchangePasswordview = '/changePasswordview';
  static String kSmartAcanView = '/SmartAcanView';

  static GoRouter router() => GoRouter(
    initialLocation: kSplash,

    // 🔥 NO LOGIC HERE AT ALL
    routes: [
      GoRoute(path: kSplash, builder: (context, state) => SplashView()),
      GoRoute(
        path: konBording,
        builder: (context, state) => OnBoardingView(),
      ),
      GoRoute(
        path: kSmartAcanView,
        builder: (context, state) => SmartScanScreen(),
      ),
      GoRoute(
        path: kchangePasswordview,
        builder: (context, state) => ChangePasswordView(),
      ),
      GoRoute(
        path: kwellComView,
        builder: (context, state) => WellComeView(),
      ),
      GoRoute(path: kLogin, builder: (context, state) => LoginView()),
      GoRoute(path: ksinupView, builder: (context, state) => SinUpView()),
      GoRoute(
        path: kforgetView,
        builder: (context, state) => ForgetPassView(),
      ),
      GoRoute(
        path: kprofileditview,
        builder: (context, state) => EditProfileView(),
      ),

      ShellRoute(
        builder: (context, state, child) {
          return MainLayout(child: child);
        },
        routes: [
          GoRoute(
            path: khomeView,
            builder: (context, state) => HomeView(),
          ),
          GoRoute(
            path: kprofileview,
            builder: (context, state) => ProfileView(),
          ),
        ],
      ),
    ],
  );
}

class MainLayout extends StatelessWidget {
  final Widget child;

  MainLayout({super.key, required this.child});

  int _getIndex(String location) {
    if (location == AppRouter.kprofileview) return 0;
    if (location == AppRouter.khomeView) return 3;
    return 3;
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();

    return Scaffold(
      body: child,
      bottomNavigationBar: CustomNavBar(currentIndex: _getIndex(location)),
    );
  }
}
