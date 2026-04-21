import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sakeena_app/core/utils/app_router.dart';
import 'package:sakeena_app/core/widgets/coustem_eleveted_butten.dart';
import 'package:sakeena_app/features/auth/logic/auth_cubit.dart';
import 'package:sakeena_app/features/auth/presentation/view/widgets/email_step.dart';
import 'package:sakeena_app/features/auth/presentation/view/widgets/forget_pass_app_bar.dart';
import 'package:sakeena_app/features/auth/presentation/view/widgets/otp_set_up.dart';
import 'package:sakeena_app/features/auth/presentation/view/widgets/reset_pass_set_up.dart';

class ForgetPassViewBody extends StatefulWidget {
  const ForgetPassViewBody({super.key});

  @override
  State<ForgetPassViewBody> createState() => _ForgetPassViewBodyState();
}

class _ForgetPassViewBodyState extends State<ForgetPassViewBody> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  // ── controllers نبعتها للـ steps ─────────────────────────────────────────
  final TextEditingController _emailController = TextEditingController();
  final List<TextEditingController> _otpControllers = List.generate(
    5,
    (_) => TextEditingController(),
  );
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _pageController.dispose();
    _emailController.dispose();
    for (var c in _otpControllers) {
      c.dispose();
    }
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // ── الـ OTP كـ string واحدة ───────────────────────────────────────────────
  String get _otpCode => _otpControllers.map((c) => c.text).join();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }

        // ✅ بعد forgetPassword ننتقل لـ OTP
        if (state is ForgetPasswordSuccess) {
          _nextPage();
        }

        // ✅ بعد verifyCode ننتقل لـ ResetPassword
        if (state is VerifyCodeSuccess) {
          _nextPage();
        }

        // ✅ بعد resetPassword نروح لـ Login
        if (state is ResetPasswordSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('تم تغيير الباسورد بنجاح ✅'),
              backgroundColor: Colors.green,
            ),
          );
          Future.delayed(const Duration(seconds: 1), () {
            if (context.mounted) context.go(AppRouter.kLogin);
          });
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;

        return Stack(
          children: [
            Column(
              children: [
                const SizedBox(height: 50),
                const CustomAppBar(titel: 'نسيت الباسوورد'),
                const SizedBox(height: 30),
                _buildPages(),
                const SizedBox(height: 20),
                _buildButton(context, isLoading),
                const SizedBox(height: 20),
              ],
            ),

            // ✅ loading overlay
            if (isLoading)
              ColoredBox(
                color: Colors.black.withValues(alpha: 0.4),
                child: const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildPages() {
    return Expanded(
      child: PageView(
        controller: _pageController,
        physics:
            const NeverScrollableScrollPhysics(), // ✅ المستخدم ميقدرش يسوايب
        onPageChanged: (index) => setState(() => _currentIndex = index),
        children: [
          EmailStep(emailController: _emailController),
          OtpStep(controllers: _otpControllers),
          ResetPassStep(
            newPasswordController: _newPasswordController,
            confirmPasswordController: _confirmPasswordController,
          ),
        ],
      ),
    );
  }

  Widget _buildButton(BuildContext context, bool isLoading) {
    return CoustemElevetedBoutten(
      text: _getButtonText(),
      onPressed: isLoading ? null : () => _handleNext(context),
      height: 60,
      backgroundcolor: const Color(0xffA53860),
      fontSize: 18,
    );
  }

  void _handleNext(BuildContext context) {
    final cubit = context.read<AuthCubit>();

    switch (_currentIndex) {
      case 0: // ── Email Step ────────────────────────────────────────────────
        final email = _emailController.text.trim();
        if (email.isEmpty) {
          _showError(context, 'من فضلك ادخلي الايميل');
          return;
        }
        cubit.forgetPassword(email: email);

      case 1: // ── OTP Step ──────────────────────────────────────────────────
        if (_otpCode.length < 5) {
          _showError(context, 'من فضلك ادخلي كود التحقق كامل');
          return;
        }
        cubit.verifyCode(email: _emailController.text.trim(), code: _otpCode);

      case 2: // ── Reset Password Step ───────────────────────────────────────
        final newPass = _newPasswordController.text;
        final confirmPass = _confirmPasswordController.text;

        if (newPass.isEmpty || confirmPass.isEmpty) {
          _showError(context, 'من فضلك ادخلي الباسورد');
          return;
        }
        if (newPass != confirmPass) {
          _showError(context, 'الباسورد مش متطابق');
          return;
        }

        cubit.resetPassword(
          email: _emailController.text.trim(),
          code: _otpCode,
          newPassword: newPass,
          confirmPassword: confirmPass,
        );
    }
  }

  void _nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  String _getButtonText() {
    if (_currentIndex == 0) return 'ارسل الايميل';
    if (_currentIndex == 1) return 'تحقق';
    return 'تغيير الباسورد';
  }
}
