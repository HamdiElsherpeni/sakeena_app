import 'package:flutter/material.dart';
import 'package:sakeena_app/core/widgets/coustem_eleveted_butten.dart';
import 'package:sakeena_app/core/resources/app_colors.dart';
import 'package:sakeena_app/features/auth/presentation/view/widgets/custom_circle_avatar.dart';
import 'package:sakeena_app/features/auth/presentation/view/widgets/custom_googel_button.dart';
import 'package:sakeena_app/features/auth/presentation/view/widgets/custom_login_wellcom_text.dart';
import 'log_in_form.dart'; // استدعاء الفورم من الملف الثاني

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomCircleAvatar(),
          const SizedBox(height: 10),
          const CustomLoginWellcomText(),
          const SizedBox(height: 30),

          // الفورم
          const LogInForm(),

          const SizedBox(height: 10),
          // Forget Password
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {},
              child: Text(
                'هل نسيت كلمة السر؟',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),
          CoustemElevetedBoutten(
            text: 'تسجيل الحساب',
            backgroundcolor: AppColors.primary,
            height: 60,
            onPressed: () {
              // هنا ممكن تتحقق من الفورم أو تعمل login
            },
          ),
          const SizedBox(height: 30),

          // Divider + Google
          Row(
            children: [
              Expanded(child: Divider(color: Colors.grey.shade400, thickness: 1)),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text('او سجل من خلال', style: TextStyle(color: Colors.grey)),
              ),
              Expanded(child: Divider(color: Colors.grey.shade400, thickness: 1)),
            ],
          ),
          const SizedBox(height: 30),

          const CustomGoogelButton(),
          const SizedBox(height: 30),

          // رابط انشاء حساب جديد
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('ليس لديك حساب؟ ', style: TextStyle(color: Colors.grey)),
              GestureDetector(
                onTap: () {},
                child: Text(
                  'انشئ حسابك',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}