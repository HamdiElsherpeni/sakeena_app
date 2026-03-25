import 'package:flutter/material.dart';
import 'package:sakeena_app/core/widgets/coustem_text_form_filed.dart';

class ResetPassStep extends StatelessWidget {
  const ResetPassStep({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/images/forgetpass2.png', height: 200),
        const SizedBox(height: 20),

        // الباسورد الجديد
        const CoustemTextFormFailed(
          hent: 'ادخلي الباسورد الجديد',
          leble: 'الباسورد الجديد',
          obscure: true,
          height: 60, // اختياري، افتراضي 60
        ),

        const SizedBox(height: 15),

        // تأكيد الباسورد
        const CoustemTextFormFailed(
          
          hent: 'أعيدي كتابة الباسورد',
          leble: 'تأكيد الباسورد',
          obscure: true,
          height: 60,
        ),
      ],
    );
  }
}