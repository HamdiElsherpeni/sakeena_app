import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        if (state is ForgetPasswordSuccess) _nextPage();
        if (state is VerifyCodeSuccess) _nextPage();
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
            // ✅ SingleChildScrollView بدون Expanded جوّاها
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 50.h),
                  CustomAppBar(titel: 'نسيت الباسوورد'),
                  SizedBox(height: 30.h),
                  _buildPages(context), // ✅ مش Expanded هنا
                  SizedBox(height: 20.h),
                  _buildButton(context, isLoading),
                  SizedBox(height: 20.h),
                ],
              ),
            ),

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

  Widget _buildPages(BuildContext context) {
    // ✅ SizedBox بارتفاع محدد بدل Expanded
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.55,
      child: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: CoustemElevetedBoutten(
        text: _getButtonText(),
        onPressed: isLoading ? null : () => _handleNext(context),
        height: 60.h,
        backgroundcolor: const Color(0xffA53860),
        fontSize: 18.sp,
      ),
    );
  }

  void _handleNext(BuildContext context) {
    final cubit = context.read<AuthCubit>();

    switch (_currentIndex) {
      case 0:
        final email = _emailController.text.trim();
        if (email.isEmpty) {
          _showError(context, 'من فضلك ادخلي الايميل');
          return;
        }
        cubit.forgetPassword(email: email);

      case 1:
        if (_otpCode.length < 5) {
          _showError(context, 'من فضلك ادخلي كود التحقق كامل');
          return;
        }
        cubit.verifyCode(email: _emailController.text.trim(), code: _otpCode);

      case 2:
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
