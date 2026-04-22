import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakeena_app/core/widgets/coustem_text_form_filed.dart';

class ResetPassStep extends StatelessWidget {
  final TextEditingController newPasswordController;
  final TextEditingController confirmPasswordController;

  ResetPassStep({
    super.key,
    required this.newPasswordController,
    required this.confirmPasswordController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/images/forgetpass2.png', height: 200.h),
        SizedBox(height: 20.h),
        CoustemTextFormFailed(
          hent: 'ادخلي الباسورد الجديد',
          leble: 'الباسورد الجديد',
          obscure: true,
          controller: newPasswordController,
        ),
        SizedBox(height: 15.h),
        CoustemTextFormFailed(
          hent: 'أعيدي كتابة الباسورد',
          leble: 'تأكيد الباسورد',
          obscure: true,
          controller: confirmPasswordController,
        ),
      ],
    );
  }
}
