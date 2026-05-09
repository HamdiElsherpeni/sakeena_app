import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakeena_app/core/resources/app_colors.dart';
import 'package:sakeena_app/features/exam_history/data/models/prediction_history_model.dart';

class ExamReportScreen extends StatelessWidget {
  const ExamReportScreen({super.key, required this.exam});

  final PredictionHistoryModel exam;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.kprimaryColor,
        body: SafeArea(
          child: Column(
            children: [
              _ReportAppBar(),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _ImageCard(imageUrl: exam.imageUrl),
                      SizedBox(height: 16.h),
                      _DiagnosisCard(exam: exam),
                      SizedBox(height: 16.h),
                      _TipsCard(status: exam.predictionStatus),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── AppBar ──────────────────────────────────────────────────────────────────

class _ReportAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15.r),
          bottomRight: Radius.circular(15.r),
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 36.w,
              height: 36.w,
              decoration: BoxDecoration(
                color: AppColors.kprimaryColor,
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: AppColors.border, width: 1.w),
              ),
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16.sp,
                color: AppColors.primary,
              ),
            ),
          ),
          Expanded(
            child: Text(
              'تقرير الفحص',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
                fontFamily: 'Rubik',
              ),
            ),
          ),
          SizedBox(width: 36.w),
        ],
      ),
    );
  }
}

// ─── Image Card ───────────────────────────────────────────────────────────────

class _ImageCard extends StatelessWidget {
  const _ImageCard({required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.border, width: 1.w),
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: AppColors.kprimaryColor,
              border: Border(
                bottom: BorderSide(color: AppColors.border, width: 1.w),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.image_outlined,
                  size: 18.sp,
                  color: AppColors.primary,
                ),
                SizedBox(width: 8.w),
                Text(
                  'صورة الفحص',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textDark,
                    fontFamily: 'Rubik',
                  ),
                ),
              ],
            ),
          ),
          imageUrl.isNotEmpty
              ? Image.network(
                  imageUrl,
                  height: 240.h,
                  fit: BoxFit.cover,
                  loadingBuilder: (_, child, progress) {
                    if (progress == null) return child;
                    return SizedBox(
                      height: 240.h,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primary,
                          value: progress.expectedTotalBytes != null
                              ? progress.cumulativeBytesLoaded /
                                    progress.expectedTotalBytes!
                              : null,
                        ),
                      ),
                    );
                  },
                  errorBuilder: (_, __, ___) => SizedBox(
                    height: 240.h,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.broken_image_outlined,
                          size: 48.sp,
                          color: AppColors.textSecondary,
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'تعذّر تحميل الصورة',
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: AppColors.textSecondary,
                            fontFamily: 'Rubik',
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : SizedBox(
                  height: 240.h,
                  child: Center(
                    child: Icon(
                      Icons.image_not_supported_outlined,
                      size: 48.sp,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}

// ─── Diagnosis Card ───────────────────────────────────────────────────────────

class _DiagnosisCard extends StatelessWidget {
  const _DiagnosisCard({required this.exam});

  final PredictionHistoryModel exam;

  @override
  Widget build(BuildContext context) {
    final status = exam.predictionStatus;
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: _borderColor(status), width: 1.2.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(
                Icons.analytics_outlined,
                size: 18.sp,
                color: AppColors.primary,
              ),
              SizedBox(width: 8.w),
              Text(
                'نتيجة التحليل',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark,
                  fontFamily: 'Rubik',
                ),
              ),
            ],
          ),
          SizedBox(height: 14.h),

          // Diagnosis row
          _InfoRow(
            label: 'التشخيص',
            value: _diagnosisLabel(status),
            valueColor: _statusColor(status),
          ),
          SizedBox(height: 10.h),

          // Date row
          _InfoRow(label: 'تاريخ الفحص', value: exam.formattedDate),
          SizedBox(height: 14.h),

          // Confidence bar
          _ConfidenceBar(confidence: exam.confidence, status: status),
        ],
      ),
    );
  }

  String _diagnosisLabel(PredictionStatus s) {
    switch (s) {
      case PredictionStatus.benign:
        return 'حميد (Benign)';
      case PredictionStatus.malignant:
        return 'خبيث (Malignant)';
      case PredictionStatus.unknown:
        return 'غير محدد';
    }
  }

  Color _statusColor(PredictionStatus s) {
    switch (s) {
      case PredictionStatus.benign:
        return const Color(0xFF2E7D32);
      case PredictionStatus.malignant:
        return const Color(0xFFC72063);
      case PredictionStatus.unknown:
        return const Color(0xFFF57F17);
    }
  }

  Color _borderColor(PredictionStatus s) {
    switch (s) {
      case PredictionStatus.benign:
        return const Color(0xFF4CAF50).withOpacity(0.3);
      case PredictionStatus.malignant:
        return const Color(0xFFC72063).withOpacity(0.3);
      case PredictionStatus.unknown:
        return const Color(0xFFFFB300).withOpacity(0.4);
    }
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value, this.valueColor});

  final String label;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: valueColor ?? AppColors.textDark,
            fontFamily: 'Rubik',
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 13.sp,
            color: AppColors.textSecondary,
            fontFamily: 'Rubik',
          ),
        ),
      ],
    );
  }
}

class _ConfidenceBar extends StatelessWidget {
  const _ConfidenceBar({required this.confidence, required this.status});

  final double confidence;
  final PredictionStatus status;

  @override
  Widget build(BuildContext context) {
    final percent = (confidence * 100).toStringAsFixed(1);
    final color = _barColor(status);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '$percent%',
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: color,
                fontFamily: 'Rubik',
              ),
            ),
            Text(
              'نسبة الثقة',
              style: TextStyle(
                fontSize: 13.sp,
                color: AppColors.textSecondary,
                fontFamily: 'Rubik',
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        ClipRRect(
          borderRadius: BorderRadius.circular(8.r),
          child: LinearProgressIndicator(
            value: confidence.clamp(0.0, 1.0),
            minHeight: 8.h,
            backgroundColor: AppColors.border,
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      ],
    );
  }

  Color _barColor(PredictionStatus s) {
    switch (s) {
      case PredictionStatus.benign:
        return const Color(0xFF4CAF50);
      case PredictionStatus.malignant:
        return const Color(0xFFC72063);
      case PredictionStatus.unknown:
        return const Color(0xFFFFB300);
    }
  }
}

// ─── Tips Card ────────────────────────────────────────────────────────────────

class _TipsCard extends StatelessWidget {
  const _TipsCard({required this.status});

  final PredictionStatus status;

  @override
  Widget build(BuildContext context) {
    final tips = _getTips(status);
    final color = _tipColor(status);
    final icon = _tipIcon(status);
    final title = _tipTitle(status);

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: color.withOpacity(0.3), width: 1.2.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(icon, size: 18.sp, color: color),
              SizedBox(width: 8.w),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark,
                  fontFamily: 'Rubik',
                ),
              ),
            ],
          ),
          SizedBox(height: 14.h),
          ...tips.map(
            (tip) => Padding(
              padding: EdgeInsets.only(bottom: 10.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      tip,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: AppColors.textDark,
                        height: 1.6,
                        fontFamily: 'Rubik',
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Container(
                    margin: EdgeInsets.only(top: 5.h),
                    width: 7.w,
                    height: 7.w,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
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

  List<String> _getTips(PredictionStatus s) {
    switch (s) {
      case PredictionStatus.benign:
        return [
          'نتيجة الفحص تشير إلى أن الورم حميد، وهذا مطمئن جداً.',
          'احرصي على إجراء فحص دوري كل 6 أشهر للاطمئنان المستمر.',
          'مارسي الرياضة بانتظام وحافظي على نظام غذائي صحي.',
          'تجنبي التدخين والكحول للحفاظ على صحة الثدي.',
          'في حال ظهور أي تغيير في الشكل أو الإحساس، راجعي الطبيب فوراً.',
        ];
      case PredictionStatus.malignant:
        return [
          'نتيجة الفحص تستوجب مراجعة الطبيب المختص في أقرب وقت ممكن.',
          'لا تؤخري الاستشارة الطبية — التشخيص المبكر يرفع نسبة الشفاء بشكل كبير.',
          'اطلبي تقرير تفصيلي من الطبيب يوضح مراحل العلاج المقترحة.',
          'احرصي على الدعم النفسي — التحدث مع المختصين يساعد كثيراً.',
          'تابعي كل التعليمات الطبية بدقة ولا تتوقفي عن الأدوية بدون إذن الطبيب.',
        ];
      case PredictionStatus.unknown:
        return [
          'النتيجة غير محددة وتحتاج إلى مزيد من الفحوصات للتأكد.',
          'راجعي طبيبك لإجراء فحص إضافي مثل الخزعة أو التصوير بالرنين.',
          'لا داعي للقلق الزائد، لكن لا تؤجلي المتابعة الطبية.',
          'دوّني أي أعراض تلاحظينها وأخبري الطبيب بها.',
          'الفحص المبكر والمنتظم هو أفضل وسيلة للحماية.',
        ];
    }
  }

  Color _tipColor(PredictionStatus s) {
    switch (s) {
      case PredictionStatus.benign:
        return const Color(0xFF4CAF50);
      case PredictionStatus.malignant:
        return const Color(0xFFC72063);
      case PredictionStatus.unknown:
        return const Color(0xFFFFB300);
    }
  }

  IconData _tipIcon(PredictionStatus s) {
    switch (s) {
      case PredictionStatus.benign:
        return Icons.tips_and_updates_outlined;
      case PredictionStatus.malignant:
        return Icons.warning_amber_rounded;
      case PredictionStatus.unknown:
        return Icons.info_outline_rounded;
    }
  }

  String _tipTitle(PredictionStatus s) {
    switch (s) {
      case PredictionStatus.benign:
        return 'نصائح للحفاظ على صحتك';
      case PredictionStatus.malignant:
        return 'خطوات مهمة يجب اتباعها';
      case PredictionStatus.unknown:
        return 'توصيات للمتابعة';
    }
  }
}
