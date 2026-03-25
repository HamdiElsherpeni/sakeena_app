import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sakeena_app/core/resources/app_colors.dart';
import 'package:sakeena_app/core/utils/app_router.dart';
import 'package:sakeena_app/core/widgets/coustem_eleveted_butten.dart';
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
  final PageController controller = PageController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSpacing(50),
        const ForgetPassAppBar(),
        _buildSpacing(30),

        _buildSpacing(20),
        _buildPages(),
        _buildSpacing(20),
        _buildButton(),
        SizedBox(height: 200,)
      ],
    );
  }

  /// 🔹 Indicator

  /// 🔹 Pages
  Widget _buildPages() {
    return Expanded(
      child: PageView(
        controller: controller,
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        children: const [EmailStep(), OtpStep(), ResetPassStep()],
      ),
    );
  }

  /// 🔹 Button
  Widget _buildButton() {
    return CoustemElevetedBoutten(
      text: _getButtonText(),
      onPressed: _handleNext,
      height: 60,
      backgroundcolor: const Color(0xffA53860),
      fontSize: 18,
    );
  }

  void _handleNext() {
    if (currentIndex == 2) {
    GoRouter.of(context).pushReplacement(AppRouter.kLogin);
    } else {
      controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
    
  }

  String _getButtonText() {
    if (currentIndex == 0) return 'ارسل الايميل';
    if (currentIndex == 1) return 'تحقق';
    return 'تغيير الباسورد';
  }

  Widget _buildSpacing(double h) => SizedBox(height: h);
  
}
