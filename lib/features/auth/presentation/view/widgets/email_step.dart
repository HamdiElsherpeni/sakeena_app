import 'package:flutter/material.dart';
import 'package:sakeena_app/core/widgets/coustem_text_form_filed.dart';

class EmailStep extends StatelessWidget {
  final TextEditingController emailController;

  const EmailStep({super.key, required this.emailController});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/images/forgetpass1.png', height: 200),
        const SizedBox(height: 20),
        const Text(
          'ادخلي ايميلك الخاص بالحساب',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 20),
        CoustemTextFormFailed(
          hent: 'الايميل',
          controller: emailController,
          prefixIcon: const Icon(Icons.email_outlined, color: Colors.black),
        ),
      ],
    );
  }
}
