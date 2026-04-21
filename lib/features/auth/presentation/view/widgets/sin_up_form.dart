import 'package:flutter/material.dart';
import 'package:sakeena_app/core/resources/app_colors.dart';
import 'package:sakeena_app/core/widgets/coustem_text_form_filed.dart';
import 'package:sakeena_app/features/auth/presentation/view/widgets/form_header.dart';
import 'package:sakeena_app/features/auth/presentation/view/widgets/password_rules.dart';

class SinUpForm extends StatefulWidget {
  const SinUpForm({
    super.key,
    required this.firstNameController,
    required this.lastNameController,
    required this.emailController,
    required this.passwordController,
    required this.isObscure,
    required this.toggleObscure,
    required this.onRegister,
    required this.isLoading,
  });

  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  final bool isObscure;
  final VoidCallback toggleObscure;

  final VoidCallback onRegister;
  final bool isLoading;

  @override
  State<SinUpForm> createState() => _SinUpFormState();
}

class _SinUpFormState extends State<SinUpForm> {
  bool _isFormValid = false;

  bool hasLower = false;
  bool hasUpper = false;
  bool hasNumber = false;
  bool hasSpecial = false;

  @override
  void initState() {
    super.initState();
    widget.firstNameController.addListener(_validate);
    widget.lastNameController.addListener(_validate);
    widget.emailController.addListener(_validate);
    widget.passwordController.addListener(_validate);
  }

  void _validate() {
    final firstName = widget.firstNameController.text.trim();
    final lastName = widget.lastNameController.text.trim();
    final email = widget.emailController.text.trim();
    final password = widget.passwordController.text;

    // ✅ email validation
    final isEmailValid = RegExp(
      r'^[\w-.]+@([\w-]+\.)+[\w]{2,4}$',
    ).hasMatch(email);

    setState(() {
      hasLower = RegExp(r'[a-z]').hasMatch(password);
      hasUpper = RegExp(r'[A-Z]').hasMatch(password);
      hasNumber = RegExp(r'\d').hasMatch(password);
      hasSpecial = RegExp(r'[@$!%*?&]').hasMatch(password);
    });

    final isPasswordValid = hasLower && hasUpper && hasNumber && hasSpecial;

    final isValid =
        firstName.isNotEmpty &&
        lastName.isNotEmpty &&
        isEmailValid && // ✅ بدل email.isNotEmpty
        password.isNotEmpty &&
        isPasswordValid;

    if (isValid != _isFormValid) {
      setState(() => _isFormValid = isValid);
    }
  }

  @override
  void dispose() {
    widget.firstNameController.removeListener(_validate);
    widget.lastNameController.removeListener(_validate);
    widget.emailController.removeListener(_validate);
    widget.passwordController.removeListener(_validate);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── الاسم ────────────────────────────────────────────────────────────
        const FormHeader(title: "الاسم"),
        const SizedBox(height: 5),
        Row(
          children: [
            Expanded(
              child: CoustemTextFormFailed(
                hent: 'الاسم الاول',
                controller: widget.firstNameController,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: CoustemTextFormFailed(
                hent: 'الاسم الثاني',
                controller: widget.lastNameController,
              ),
            ),
          ],
        ),

        const SizedBox(height: 20),

        // ── الايميل ──────────────────────────────────────────────────────────
        const FormHeader(title: "الايميل"),
        const SizedBox(height: 5),
        CoustemTextFormFailed(
          hent: 'SakeenaTeam@gmail.com',
          controller: widget.emailController,
          keyboardType: TextInputType.emailAddress, // ✅
        ),

        const SizedBox(height: 20),

        // ── كلمة المرور ──────────────────────────────────────────────────────
        const FormHeader(title: "كلمة المرور"),
        const SizedBox(height: 5),
        CoustemTextFormFailed(
          hent: 'ادخل كلمة المرور',
          obscure: widget.isObscure,
          controller: widget.passwordController,
          sufixIcon: IconButton(
            icon: Icon(
              widget.isObscure ? Icons.visibility_off : Icons.visibility,
              color: Colors.grey,
            ),
            onPressed: widget.toggleObscure,
          ),
        ),

        const SizedBox(height: 10),

        // ── Password Rules ───────────────────────────────────────────────────
        PasswordRules(
          hasLower: hasLower,
          hasUpper: hasUpper,
          hasNumber: hasNumber,
          hasSpecial: hasSpecial,
        ),

        const SizedBox(height: 25),

        // ── زرار التسجيل ─────────────────────────────────────────────────────
        SizedBox(
          width: double.infinity,
          height: 55,
          child: ElevatedButton(
            onPressed: widget.isLoading || !_isFormValid
                ? null
                : widget.onRegister,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              disabledBackgroundColor: Colors.grey.shade400,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: widget.isLoading
                ? const CircularProgressIndicator(color: Colors.white)
                : const Text(
                    'إنشاء حساب',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
