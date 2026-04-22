import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakeena_app/core/widgets/custom_circle_avatar.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, required this.titel});
  final String titel;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomCircleAvatar(),
        SizedBox(width: 60.w),
        Text(
          titel,
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
