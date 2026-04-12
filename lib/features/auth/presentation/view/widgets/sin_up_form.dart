import 'package:flutter/material.dart';
import 'package:sakeena_app/core/resources/app_colors.dart';
import 'package:sakeena_app/core/widgets/coustem_eleveted_butten.dart';
import 'package:sakeena_app/core/widgets/coustem_text_form_filed.dart';

class SinUpForm extends StatelessWidget {
  const SinUpForm({
    super.key,
    required this.firstNameController,
    required this.lastNameController,
    required this.emailController,
    required this.passwordController,
    required this.isObscure,
    required this.toggleObscure,
  });

  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  final bool isObscure;
  final VoidCallback toggleObscure;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // First + Last Name
        const Text(
          'الاسم',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 5),

        Row(
          children: [
            // First Name
            Expanded(
              child: CoustemTextFormFailed(
                hent: 'الاسم الاول',
                controller: firstNameController,
              ),
            ),
            const SizedBox(width: 10),

            // Last Name
            Expanded(
              child: CoustemTextFormFailed(
                hent: 'الاسم الثاني',
                controller: lastNameController,
              ),
            ),
          ],
        ),

        const SizedBox(height: 20),

        // Email
        const Text(
          'الايميل',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 5),
        CoustemTextFormFailed(
          hent: 'SakeenaTeam@gmail.com',
          controller: emailController,
        ),

        const SizedBox(height: 20),

        // Password
        const Text(
          'الباسوورد',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 5),
        CoustemTextFormFailed(
          hent: 'ادخل كلمة المرور',
          obscure: isObscure,
          controller: passwordController,
          sufixIcon: IconButton(
            icon: Icon(
              isObscure ? Icons.visibility_off : Icons.visibility,
              color: Colors.grey,
            ),
            onPressed: toggleObscure,
          ),
        ),

        const SizedBox(height: 20),

        // Button
        CoustemElevetedBoutten(
          text: 'انشاء حساب',
          backgroundcolor: AppColors.primary,
          height: 60,
        ),
      ],
    );
  }
}