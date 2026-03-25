import 'package:go_router/go_router.dart';
import 'package:sakeena_app/features/auth/presentation/view/forget_pass_view.dart';
import 'package:sakeena_app/features/auth/presentation/view/login_view.dart';
import 'package:sakeena_app/features/auth/presentation/view/sin_up_view.dart';
import 'package:sakeena_app/features/onboarding/presentation/view/on_bording_view.dart';
import 'package:sakeena_app/features/onboarding/presentation/view/wellcome_view.dart';
import 'package:sakeena_app/features/splash/presentation/view/splash_view.dart';

abstract class AppRouter {
  static String konBording = '/onbording';
  static String kwellComView = '/wellcomview';
  static String kLogin = '/login';
  static String ksinupView = '/SinupView';
static String kforgetView = '/forgetview';
  static final router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashView()),
      GoRoute(
        path: konBording,
        builder: (context, state) => const OnBoardingView(),
      ),
      GoRoute(
        path: kwellComView,
        builder: (context, state) => const WellComeView(),
      ),
       GoRoute(
        path: kforgetView,
        builder: (context, state) => const ForgetPassView(),
      ),
      GoRoute(path: kLogin, builder: (context, state) => const LoginView()),
      GoRoute(path: ksinupView, builder: (context, state) => const SinUpView()),
    ],
  );
}
