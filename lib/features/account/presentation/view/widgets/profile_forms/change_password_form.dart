import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakeena_app/core/widgets/coustem_text_form_filed.dart';

class ChangePasswordForm extends StatefulWidget {
  final void Function(
    String current,
    String newPass,
    String confirm,
    bool isValid,
  )
  onChanged;

  ChangePasswordForm({super.key, required this.onChanged});

  @override
  State<ChangePasswordForm> createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<ChangePasswordForm> {
  final currentController = TextEditingController();
  final newController = TextEditingController();
  final confirmController = TextEditingController();

  bool isCurrentObscure = true;
  bool isNewObscure = true;
  bool isConfirmObscure = true;

  void _validate() {
    final current = currentController.text;
    final newPass = newController.text;
    final confirm = confirmController.text;

    final isValid =
        current.length >= 6 && newPass.length >= 6 && newPass == confirm;

    widget.onChanged(current, newPass, confirm, isValid);
  }

  @override
  void initState() {
    super.initState();
    currentController.addListener(_validate);
    newController.addListener(_validate);
    confirmController.addListener(_validate);
  }

  @override
  void dispose() {
    currentController.dispose();
    newController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // كلمة المرور الحالية
        Text(
          'كلمة المرور الحالية',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
        ),
        SizedBox(height: 8.h),
        CoustemTextFormFailed(
          hent: '...........',
          controller: currentController,
          obscure: isCurrentObscure,
          sufixIcon: IconButton(
            icon: Icon(
              isCurrentObscure ? Icons.visibility_off : Icons.visibility,
            ),
            onPressed: () =>
                setState(() => isCurrentObscure = !isCurrentObscure),
          ),
          validator: (value) {
            if (value == null || value.isEmpty)
              return 'ادخل كلمة المرور الحالية';
            if (value.length < 6) return 'كلمة المرور قصيرة جداً';
            return null;
          },
        ),

        SizedBox(height: 20.h),

        // كلمة المرور الجديدة
        Text(
          'كلمة المرور الجديدة',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
        ),
        SizedBox(height: 8.h),
        CoustemTextFormFailed(
          hent: '...........',
          controller: newController,
          obscure: isNewObscure,
          sufixIcon: IconButton(
            icon: Icon(isNewObscure ? Icons.visibility_off : Icons.visibility),
            onPressed: () => setState(() => isNewObscure = !isNewObscure),
          ),
          validator: (value) {
            if (value == null || value.isEmpty)
              return 'ادخل كلمة المرور الجديدة';
            if (value.length < 6) return 'كلمة المرور قصيرة جداً';
            return null;
          },
        ),

        SizedBox(height: 20.h),

        // تأكيد كلمة المرور الجديدة
        Text(
          'تأكيد كلمة المرور الجديدة',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
        ),
        SizedBox(height: 8.h),
        CoustemTextFormFailed(
          hent: '...........',
          controller: confirmController,
          obscure: isConfirmObscure,
          sufixIcon: IconButton(
            icon: Icon(
              isConfirmObscure ? Icons.visibility_off : Icons.visibility,
            ),
            onPressed: () =>
                setState(() => isConfirmObscure = !isConfirmObscure),
          ),
          validator: (value) {
            if (value == null || value.isEmpty)
              return 'تأكيد كلمة المرور مطلوب';
            if (value != newController.text) return 'كلمة المرور غير متطابقة';
            return null;
          },
        ),
      ],
    );
  }
}
