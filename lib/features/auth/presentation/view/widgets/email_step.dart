import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakeena_app/core/widgets/coustem_text_form_filed.dart';

class EmailStep extends StatelessWidget {
  final TextEditingController emailController;

  const EmailStep({super.key, required this.emailController});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/images/forgetpass1.png', height: 200.h),
        SizedBox(height: 20.h),
        Text(
          'ادخلي ايميلك الخاص بالحساب',
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w800),
        ),
        SizedBox(height: 20.h),
        CoustemTextFormFailed(
          hent: 'الايميل',
          controller: emailController,
          prefixIcon: Icon(Icons.email_outlined, color: Colors.black),
        ),
      ],
    );
  }
}
