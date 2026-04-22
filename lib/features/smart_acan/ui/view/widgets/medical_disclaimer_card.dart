import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MedicalDisclaimerCard extends StatelessWidget {
  const MedicalDisclaimerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Color(0xFFFFF3CD),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: Color(0xFFFFE082), width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline_rounded,
            color: Color(0xFFF59E0B),
            size: 20.sp,
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: RichText(
              textDirection: TextDirection.rtl,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'تنويه طبي مهم\n',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp,
                      color: Colors.black87,
                      fontFamily: 'Cairo',
                    ),
                  ),
                  TextSpan(
                    text:
                        'هذا التطبيق أداة مساعدة فقط، والنتائج إرشادية ولا تغني عن استشارة طبيب مختص',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.grey,
                      height: 1.5,
                      fontFamily: 'Cairo',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
