import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomLoginWellcomText extends StatelessWidget {
  const CustomLoginWellcomText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
           // عنوان ترحيبي
          Text(
            'أهلاً بك في سكينة!',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.sp),
            textAlign: TextAlign.right,
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              Text(
                'رحلتك نحو الوقاية والعناية بنفسك .',
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15.sp),
                textAlign: TextAlign.right,
              ),
              Text(
                'تبدأ من هنا',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
                textAlign: TextAlign.right,
              ),
            ],
          ),
    ],);
  }
}