import 'package:flutter/material.dart';
import 'package:sakeena_app/core/widgets/coustem_text_form_filed.dart';

class LogInForm extends StatefulWidget {
  const LogInForm({super.key});

  @override
  State<LogInForm> createState() => _LogInFormState();
}

class _LogInFormState extends State<LogInForm> {
  bool isObscure = true;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('الايميل', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 5),
          CoustemTextFormFailed(
            hent: 'SakeenaTeam@gmail.com',
            controller: emailController,
            validator: (value) {
              if (value == null || value.isEmpty) return 'من فضلك ادخل الايميل';
              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}').hasMatch(value)) {
                return 'الايميل غير صحيح';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          Text('الباسوورد', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 5),
          CoustemTextFormFailed(
            hent: 'ادخل كلمة المرور',
            obscure: isObscure,
            controller: passwordController,
            sufixIcon: IconButton(
              icon: Icon(isObscure ? Icons.visibility_off : Icons.visibility, color: Colors.grey),
              onPressed: () {
                setState(() {
                  isObscure = !isObscure;
                });
              },
            ),
            validator: (value) {
              if (value == null || value.isEmpty) return 'من فضلك ادخل كلمة المرور';
              if (value.length < 6) return 'كلمة المرور قصيرة جداً';
              return null;
            },
          ),
        ],
      ),
    );
  }
}