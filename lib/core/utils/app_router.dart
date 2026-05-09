import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sakeena_app/core/di/service_locator.dart';
import 'package:sakeena_app/core/network/dio_factory.dart';
import 'package:sakeena_app/core/services/token_service.dart';
import 'package:sakeena_app/features/auth/presentation/view/forget_pass_view.dart';
import 'package:sakeena_app/features/auth/presentation/view/login_view.dart';
import 'package:sakeena_app/features/auth/presentation/view/sin_up_view.dart';
import 'package:sakeena_app/features/chat/presentation/view/chat_view.dart';
import 'package:sakeena_app/features/education/data/models/article_model.dart';
import 'package:sakeena_app/features/education/ui/view/education_screen.dart';
import 'package:sakeena_app/features/education/ui/view/widgets/article_screen.dart';
import 'package:sakeena_app/features/exam_history/data/models/prediction_history_model.dart';
import 'package:sakeena_app/features/exam_history/ui/exam_history_screen.dart';
import 'package:sakeena_app/features/exam_history/ui/widgets/exam_report_screen.dart';
import 'package:sakeena_app/features/home/presentation/view/home_view.dart';
import 'package:sakeena_app/core/widgets/custom_nav_bar.dart';
import 'package:sakeena_app/features/notifications/ui/view/notifications_screen.dart';
import 'package:sakeena_app/features/onboarding/presentation/view/on_bording_view.dart';
import 'package:sakeena_app/features/onboarding/presentation/view/wellcome_view.dart';
import 'package:sakeena_app/features/account/presentation/view/change_password.dart';
import 'package:sakeena_app/features/account/presentation/view/profile_view.dart';
import 'package:sakeena_app/features/account/presentation/view/widgets/etide_profile_view.dart';
import 'package:sakeena_app/features/risk_assessment/ui/view/risk_assessment.dart';
import 'package:sakeena_app/features/self_scaning/ui/view/self_exam_guide_screen.dart';
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
  static String kChatView = '/chatview';
  static String kAssessmentView = '/AssessmentView';
  static String kSelfExamGuideScreen = '/SelfExamGuideScreen';
  static String kExamHistoryScreen = '/ExamHistoryScreen';
  static String kExamReportScreen = '/ExamReportScreen';
  static String kNotificationView = '/NotificationView';
  static String kEducationView = '/EducationView';
  static String kArticleView = '/ArticleView';

  static const _publicRoutes = [
    '/',
    '/login',
    '/SinupView',
    '/forgetview',
    '/onbording',
    '/wellcomview',
  ];

  static final GoRouter _router = _buildRouter();

  static GoRouter router() {
    DioFactory.onLogout = () {
      _router.go(kLogin);
    };
    return _router;
  }

  static GoRouter _buildRouter() => GoRouter(
    initialLocation: kSplash,
    redirect: (context, state) async {
      final location = state.matchedLocation;
      final isPublic = _publicRoutes.contains(location);
      if (isPublic) return null;
      final hasToken = await TokenService.hasToken();
      if (!hasToken) return kLogin;
      return null;
    },
    routes: [
      GoRoute(
        path: kArticleView,
        builder: (context, state) {
          final article = state.extra as ArticleModel;
          return ArticleScreen(article: article);
        },
      ),
      // ── بدون NavBar ────────────────────────────────────────────────
      GoRoute(
        path: kChatView, // ← شيلناه من الـ Shell
        builder: (context, state) => const ChatView(),
      ),
      GoRoute(
        path: kNotificationView,
        builder: (context, state) => const NotificationsScreen(),
      ),
      GoRoute(
        path: kExamHistoryScreen,
        builder: (context, state) => const ExamHistoryScreen(),
      ),
      GoRoute(
        path: kExamReportScreen,
        builder: (context, state) {
          final exam = state.extra as PredictionHistoryModel;
          return ExamReportScreen(exam: exam);
        },
      ),
      GoRoute(
        path: kSelfExamGuideScreen,
        builder: (context, state) => const SelfExamGuideScreen(),
      ),
      GoRoute(path: kSplash, builder: (context, state) => const SplashView()),
      GoRoute(
        path: kAssessmentView,
        builder: (context, state) => const AssessmentScreen(),
      ),
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

      // ── Shell (Bottom Nav) ─────────────────────────────────────────
      ShellRoute(
        builder: (context, state, child) => MainLayout(child: child),
        routes: [
          GoRoute(
            path: kEducationView,
            builder: (context, state) => const EducationScreen(),
          ),
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
    if (location == AppRouter.kEducationView) return 1;
    if (location == AppRouter.kSmartAcanView) return 2;
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
