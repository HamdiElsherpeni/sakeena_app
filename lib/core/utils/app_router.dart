import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sakeena_app/core/di/service_locator.dart';
import 'package:sakeena_app/core/network/dio_factory.dart';
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
import 'package:sakeena_app/features/smart_acan/data/models/scan_result_model.dart';
import 'package:sakeena_app/features/smart_acan/data/repo/scan_repo.dart';
import 'package:sakeena_app/features/smart_acan/logic/cubit/scan_cubit.dart';
import 'package:sakeena_app/features/smart_acan/ui/view/scan_result_screen.dart';
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
  static String kscanResultScreen = '/scanResultScreen';

  // ✅ Singleton router instance عشان نوصله من DioFactory
  static final GoRouter _router = _buildRouter();

  static GoRouter router() {
    // ✅ ربط الـ logout callback مرة واحدة هنا
    DioFactory.onLogout = () {
      _router.go(kLogin);
    };
    return _router;
  }

  static GoRouter _buildRouter() => GoRouter(
    initialLocation: kSplash,
    routes: [
      GoRoute(path: kSplash, builder: (context, state) => const SplashView()),
      GoRoute(
        path: kscanResultScreen,
        builder: (context, state) {
          final result = state.extra as ScanResultModel;
          return ScanResultScreen(result: result);
        },
      ),
      GoRoute(
        path: konBording,
        builder: (context, state) => const OnBoardingView(),
      ),

      GoRoute(
        path: kchangePasswordview,
        builder: (context, state) => ChangePasswordView(),
      ),
      GoRoute(
        path: kwellComView,
        builder: (context, state) => const WellComeView(),
      ),
      GoRoute(path: kLogin, builder: (context, state) => const LoginView()),
      GoRoute(path: ksinupView, builder: (context, state) => const SinUpView()),
      GoRoute(
        path: kforgetView,
        builder: (context, state) => const ForgetPassView(),
      ),
      GoRoute(
        path: kprofileditview,
        builder: (context, state) => EditProfileView(),
      ),
      ShellRoute(
        builder: (context, state, child) => MainLayout(child: child),
        routes: [
          GoRoute(
            path: khomeView,
            builder: (context, state) => const HomeView(),
          ),
          GoRoute(
            path: kprofileview,
            builder: (context, state) => ProfileView(),
          ),
          GoRoute(
            path: kSmartAcanView,
            builder: (context, state) => BlocProvider(
              create: (context) => ScanCubit(getIt<ScanRepo>()),
              child: const SmartScanScreen(),
            ),
          ),
        ],
      ),
    ],
  );
}

class MainLayout extends StatelessWidget {
  final Widget child;

  const MainLayout({super.key, required this.child});

  int _getIndex(String location) {
    if (location == AppRouter.kprofileview) return 0;
    if (location == AppRouter.khomeView) return 3;
    if (location == AppRouter.kSmartAcanView) return 2;
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
