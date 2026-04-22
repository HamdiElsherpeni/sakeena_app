import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomWellcomeTextSinUp extends StatelessWidget {
  const CustomWellcomeTextSinUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'أهلاً بك في سكينة!',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.sp),
          textAlign: TextAlign.right,
        ),
        SizedBox(height: 10.h),

        Row(
         
          children: [
            Text(
              'اهلا بك في',
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 18.sp),
              
            ),
            Text(
              ' سكينة!',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
              textAlign: TextAlign.right,
            ),
            Text(
              '- قومي بانشاء حساب ',
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 18.sp),
              textAlign: TextAlign.right,
            ),
          ],
        ),
        Text('لاستخدام التطبيق '),
      ],
    );
  }
}
