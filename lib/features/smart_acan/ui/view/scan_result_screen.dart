import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sakeena_app/core/resources/app_colors.dart';
import 'package:sakeena_app/core/widgets/coustem_eleveted_butten.dart';
import 'package:sakeena_app/features/smart_acan/data/models/scan_result_model.dart';
import 'package:sakeena_app/features/smart_acan/ui/view/widgets/app_bar_widget.dart';
import 'package:sakeena_app/features/smart_acan/ui/view/widgets/medical_tip_widget.dart';
import 'package:sakeena_app/features/smart_acan/ui/view/widgets/result_card_widget.dart';

class ScanResultScreen extends StatelessWidget {
  final ScanResultModel result;

  const ScanResultScreen({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F4F6),
      appBar: AppBarWidget(
        title: 'نتيجة الفحص',
        onBack: () => Navigator.of(context).pop(),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 32),
          child: Column(
            children: [
              ResultCardWidget(
                resultTitle: result.isMalignant
                    ? 'النتيجة التحليلية: ورم خبيث ⚠️'
                    : result.isBenign
                    ? 'النتيجة التحليلية: ورم حميد 🟠'
                    : 'النتيجة التحليلية: طبيعي ✅',
                resultSubtitle: result.message,
                percentage: result.confidence * 100,
                percentageLabel: 'درجة الاحتمال',
                status: result.status, // ✅ بدل isMalignant
              ),

              Padding(
                padding: const EdgeInsets.all(16),
                child: CoustemElevetedBoutten(
                  text: 'إعادة الفحص',
                  onPressed: () => context.pop(),
                  backgroundcolor: AppColors.primary,
                  textcolor: Colors.white,
                ),
              ),

              MedicalTipWidget(
                header: 'توصية طبية',
                body: result.isMalignant
                    ? 'النتيجة تشير إلى ورم خبيث.\nيُرجى مراجعة طبيب متخصص فوراً للتأكيد والعلاج.'
                    : result.isBenign
                    ? 'النتيجة تشير إلى ورم حميد.\nيُنصح بمتابعة دورية مع الطبيب للاطمئنان.'
                    : 'النتيجة طبيعية.\nهذه النتيجة تقديرية، يُنصح بمراجعة الطبيب للتأكيد.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
