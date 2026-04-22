import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakeena_app/core/widgets/custom_circle_avatar.dart';

class ChangePasswordHeader extends StatelessWidget {
  ChangePasswordHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomCircleAvatar(),
        // عشان العنوان يبقى في المنتصف
        Text(
          'تغيير كلمة المرور',
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2D2D2D),
          ),
        ),
        SizedBox(width: 42.w),
      ],
    );
  }
}
