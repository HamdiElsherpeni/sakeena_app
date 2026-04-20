import 'package:flutter/material.dart';
import 'package:sakeena_app/features/auth/presentation/view/widgets/custom_circle_avatar.dart';

class ChangePasswordHeader extends StatelessWidget {
  const ChangePasswordHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const CustomCircleAvatar(),
        // عشان العنوان يبقى في المنتصف
        const Text(
          'تغيير كلمة المرور',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2D2D2D),
          ),
        ),
        const SizedBox(width: 42),
      ],
    );
  }
}
