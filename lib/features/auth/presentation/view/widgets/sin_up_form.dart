import 'package:flutter/material.dart';
import 'package:sakeena_app/core/resources/app_colors.dart';
import 'package:sakeena_app/core/widgets/coustem_eleveted_butten.dart';
import 'package:sakeena_app/core/widgets/coustem_text_form_filed.dart';

class SinUpForm extends StatelessWidget {
  const SinUpForm({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.isObscure,
    required this.toggleObscure,
  });

  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool isObscure;
  final VoidCallback toggleObscure;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // الاسم
        Text('الاسم كامل', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 5),
        CoustemTextFormFailed(
          hent: 'مثال: ندي محمد زعبلاوي',
          controller: nameController,
        ),
        const SizedBox(height: 20),

        // الايميل
        Text('الايميل', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 5),
        CoustemTextFormFailed(
          hent: 'SakeenaTeam@gmail.com',
          controller: emailController,
        ),
        const SizedBox(height: 20),

        // الباسوورد
        Text('الباسوورد', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 5),
        CoustemTextFormFailed(
          hent: 'ادخل كلمة المرور',
          obscure: isObscure,
          controller: passwordController,
          sufixIcon: IconButton(
            icon: Icon(isObscure ? Icons.visibility_off : Icons.visibility, color: Colors.grey),
            onPressed: toggleObscure,
          ),
        ),
        const SizedBox(height: 20),

        // زر انشاء الحساب
        CoustemElevetedBoutten(
          text: 'انشاء حساب',
          backgroundcolor: AppColors.primary,
          height: 60,
        ),
      ],
    );
  }
}