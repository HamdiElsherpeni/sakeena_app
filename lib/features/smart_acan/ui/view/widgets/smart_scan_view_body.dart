import 'package:flutter/widgets.dart';
import 'package:sakeena_app/features/smart_acan/ui/view/widgets/capture_button.dart';
import 'package:sakeena_app/features/smart_acan/ui/view/widgets/medical_disclaimer_card.dart';
import 'package:sakeena_app/features/smart_acan/ui/view/widgets/scan_header.dart';
import 'package:sakeena_app/features/smart_acan/ui/view/widgets/upload_card.dart';

class SmartScanViewBody extends StatelessWidget {
  const SmartScanViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const ScanHeader(),
        const SizedBox(height: 24),
        UploadCard(
          onTap: () {
            /* TODO: معرض الصور */
          },
        ),
        const SizedBox(height: 16),
        CaptureButton(
          onPressed: () {
            /* TODO: الكاميرا */
          },
        ),
        const SizedBox(height: 16),
        const MedicalDisclaimerCard(),
      ],
    );
  }
}
