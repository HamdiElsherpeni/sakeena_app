import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakeena_app/core/widgets/coustem_text_form_filed.dart';

class LogInForm extends StatefulWidget {
  final void Function(String email, String password, bool isValid) onChanged;

  const LogInForm({super.key, required this.onChanged}); // ✅ واحد بس

  @override
  State<LogInForm> createState() => _LogInFormState();
}

class _LogInFormState extends State<LogInForm> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isObscure = true;

  void _validate() {
    final email = emailController.text;
    final password = passwordController.text;

    final isEmailValid = RegExp(
      r'^[\w-.]+@([\w-]+\.)+[\w]{2,4}',
    ).hasMatch(email);

    final isPasswordValid = password.length >= 6;

    widget.onChanged(email, password, isEmailValid && isPasswordValid);
  }

  @override
  void initState() {
    super.initState();
    emailController.addListener(_validate);
    passwordController.addListener(_validate);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'الايميل',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
        ),
        SizedBox(height: 5.h),

        CoustemTextFormFailed(
          hent: 'SakeenaTeam@gmail.com',
          controller: emailController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'ادخل الايميل';
            }
            if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w]{2,4}').hasMatch(value)) {
              return 'الايميل غير صحيح';
            }
            return null;
          },
        ),

        SizedBox(height: 20.h),

        Text(
          'الباسوورد',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
        ),
        SizedBox(height: 5.h),

        CoustemTextFormFailed(
          hent: 'ادخل كلمة المرور',
          obscure: isObscure,
          controller: passwordController,
          sufixIcon: IconButton(
            icon: Icon(isObscure ? Icons.visibility_off : Icons.visibility),
            onPressed: () {
              setState(() => isObscure = !isObscure);
            },
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'ادخل كلمة المرور';
            }
            if (value.length < 6) {
              return 'كلمة المرور قصيرة جداً';
            }
            return null;
          },
        ),
      ],
    );
  }
}
