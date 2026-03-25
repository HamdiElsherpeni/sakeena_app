import 'package:flutter/material.dart';
import 'package:sakeena_app/core/resources/app_colors.dart';
import 'package:sakeena_app/features/auth/presentation/view/widgets/custom_circle_avatar.dart';
import 'package:sakeena_app/features/auth/presentation/view/widgets/custom_googel_button.dart';
import 'package:sakeena_app/features/auth/presentation/view/widgets/custom_wellcome_text_sin_up.dart';
import 'package:sakeena_app/features/auth/presentation/view/widgets/sin_up_form.dart';

class SinUpViewBody extends StatefulWidget {
  const SinUpViewBody({super.key});

  @override
  State<SinUpViewBody> createState() => _SinUpViewBodyState();
}

class _SinUpViewBodyState extends State<SinUpViewBody> {
  bool isObscure = true;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomCircleAvatar(),
          const SizedBox(height: 10),

          // عنوان ترحيبي
          CustomWellcomeTextSinUp(),
          const SizedBox(height: 30),

          // استدعاء الفورم
          SinUpForm(
            nameController: nameController,
            emailController: emailController,
            passwordController: passwordController,
            isObscure: isObscure,
            toggleObscure: () {
              setState(() {
                isObscure = !isObscure;
              });
            },
          ),

          const SizedBox(height: 30),
          // Divider + Google SignIn
          Row(
            children: [
              Expanded(child: Divider(color: Colors.grey.shade400, thickness: 1)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text('او سجل من خلال', style: TextStyle(color: Colors.grey)),
              ),
              Expanded(child: Divider(color: Colors.grey.shade400, thickness: 1)),
            ],
          ),
          const SizedBox(height: 30),
          CustomGoogelButton(),
          const SizedBox(height: 30),

          // رابط تسجيل الدخول
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('لدي حساب بالفعل؟', style: TextStyle(color: Colors.grey)),
              GestureDetector(
                onTap: () {},
                child: Text(
                  'سجلي من هنا',
                  style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}