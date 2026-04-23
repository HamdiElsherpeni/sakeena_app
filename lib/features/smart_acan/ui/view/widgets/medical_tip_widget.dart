import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MedicalTipWidget extends StatelessWidget {
  final String header;
  final String body;
  final IconData icon;

  const MedicalTipWidget({
    super.key,
    this.header = 'توصية طبية',
    this.body =
        'هذه النتيجة تقديرية وليست تشخيصاً نهائياً.\nيُنصح بمراجعة الطبيب للتأكيد والاطمئنان.',
    this.icon = Icons.lightbulb_outline,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 0),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: const Color(0xFFF0F0F0), width: 0.5),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32.w,
            height: 32.w,
            decoration: BoxDecoration(
              color: const Color(0xFFFFF8E1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(icon, size: 18.sp, color: const Color(0xFFF59E0B)),
          ),

          SizedBox(width: 10.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  header,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF333333),
                  ),
                ),

                SizedBox(height: 4.h),

                Text(
                  body,
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: Colors.grey,
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
