import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RuleItem extends StatelessWidget {
  final bool condition;
  final String text;

  const RuleItem({
    super.key,
    required this.condition,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          condition ? Icons.check_circle : Icons.circle_outlined,
          color: condition ? Colors.green : Colors.grey,
          size: 18,
        ),
        SizedBox(width: 8.w),
        Text(
          text,
          style: TextStyle(
            color: condition ? Colors.green : Colors.grey,
            fontSize: 13.sp,
          ),
        ),
      ],
    );
  }
}