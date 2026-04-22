import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakeena_app/core/services/camera_service.dart';
import 'package:sakeena_app/core/services/permission_service.dart';
import 'package:sakeena_app/features/smart_acan/ui/view/widgets/analyze_button.dart';
import 'package:sakeena_app/features/smart_acan/ui/view/widgets/capture_button.dart';
import 'package:sakeena_app/features/smart_acan/ui/view/widgets/medical_disclaimer_card.dart';
import 'package:sakeena_app/features/smart_acan/ui/view/widgets/scan_header.dart';
import 'package:sakeena_app/features/smart_acan/ui/view/widgets/upload_card.dart';
import 'camera_preview_screen.dart';

class SmartScanViewBody extends StatefulWidget {
  const SmartScanViewBody({super.key});

  @override
  State<SmartScanViewBody> createState() => _SmartScanViewBodyState();
}

class _SmartScanViewBodyState extends State<SmartScanViewBody> {
  final _permissionService = PermissionService();
  File? _capturedImage;

  Future<void> _onCaptureTapped() async {
    // 1. اطلب الصلاحية لما يدوس الزرار بس
    final granted = await _permissionService.request(AppPermission.camera);

    if (!mounted) return;

    if (!granted) {
      final isPermanent = await _permissionService.isPermanentlyDenied(
        AppPermission.camera,
      );
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isPermanent
                ? 'يجب تفعيل صلاحية الكاميرا من الإعدادات'
                : 'صلاحية الكاميرا مطلوبة للالتقاط',
          ),
          backgroundColor: Colors.red,
          action: isPermanent
              ? SnackBarAction(
                  label: 'الإعدادات',
                  textColor: Colors.white,
                  onPressed: _permissionService.openSettings,
                )
              : null,
        ),
      );
      return;
    }

    // 2. افتح شاشة الكاميرا كاملة
    final File? result = await Navigator.push<File>(
      context,
      MaterialPageRoute(builder: (_) => const CameraPreviewScreen()),
    );

    // 3. لو رجع بصورة اعرضها
    if (result != null && mounted) {
      setState(() => _capturedImage = result);
    }
  }

  Future<void> _pickFromGallery() async {
    // TODO: image_picker
  }

  void _analyzeImage() {
    // TODO: Analyze logic
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const ScanHeader(),
        SizedBox(height: 24.h),

        // عرض الصورة لو موجودة
        if (_capturedImage != null) ...[
          ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: Image.file(
              _capturedImage!,
              height: 250.h,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 16.h),
        ] else ...[
          UploadCard(onTap: _pickFromGallery),
          SizedBox(height: 12.h),
        ],

        CaptureButton(onPressed: _onCaptureTapped),
        SizedBox(height: 16.h),

        if (_capturedImage != null) AnalyzeButton(onPressed: _analyzeImage),

        SizedBox(height: 16.h),
        const MedicalDisclaimerCard(),
      ],
    );
  }
}
