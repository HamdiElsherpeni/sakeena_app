import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakeena_app/features/smart_acan/ui/view/widgets/score_gauge_widget.dart';

class ResultCardWidget extends StatelessWidget {
  final String resultTitle;
  final String resultSubtitle;
  final double percentage;
  final String percentageLabel;
  final String status;

  const ResultCardWidget({
    super.key,
    this.resultTitle = '',
    this.resultSubtitle = '',
    this.percentage = 0,
    this.percentageLabel = 'درجة الاحتمال',
    this.status = 'normal',
  });

  Color get _color {
    switch (status.toLowerCase()) {
      case 'malignant':
        return const Color(0xFFEF4444);

      case 'benign':
        return const Color(0xFFF97316);

      case 'normal':
      default:
        return const Color(0xFF22C55E);
    }
  }

  IconData get _icon {
    switch (status.toLowerCase()) {
      case 'malignant':
        return Icons.warning_rounded;

      case 'benign':
        return Icons.info_rounded;

      case 'normal':
      default:
        return Icons.check_circle_rounded;
    }
  }

  String get _arabicTitle {
    switch (status.toLowerCase()) {
      case 'malignant':
        return 'الورم خبيث';

      case 'benign':
        return 'الورم حميد';

      case 'normal':
      default:
        return 'لا يوجد ورم';
    }
  }

  String get _arabicSubtitle {
    switch (status.toLowerCase()) {
      case 'malignant':
        return 'ننصح بمراجعة الطبيب المختص لإجراء فحوصات إضافية في أقرب وقت.';

      case 'benign':
        return 'تم اكتشاف ورم حميد، ويفضل المتابعة الدورية للاطمئنان.';

      case 'normal':
      default:
        return 'لم يتم اكتشاف أي مؤشرات تدل على وجود ورم.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        margin: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: const Color(0xFFF0F0F0), width: 0.5),
        ),
        child: Column(
          children: [
            Container(
              width: 56.w,
              height: 56.w,
              decoration: BoxDecoration(color: _color, shape: BoxShape.circle),
              child: Icon(_icon, color: Colors.white, size: 28),
            ),

            SizedBox(height: 16.h),

            Text(
              _arabicTitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF222222),
              ),
            ),

            SizedBox(height: 6.h),

            Text(
              resultSubtitle.isEmpty ? _arabicSubtitle : resultSubtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15.sp,
                color: Colors.grey,
                height: 1.6,
              ),
            ),

            SizedBox(height: 20.h),

            const Divider(color: Color(0xFFF0F0F0), thickness: 0.5),

            SizedBox(height: 12.h),

            ScoreGaugeWidget(
              percentage: percentage,
              label: percentageLabel,
              color: _color,
            ),
          ],
        ),
      ),
    );
  }
}
