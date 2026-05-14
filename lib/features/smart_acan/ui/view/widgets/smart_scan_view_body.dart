import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sakeena_app/core/services/permission_service.dart';
import 'package:sakeena_app/core/utils/app_router.dart';
import 'package:sakeena_app/features/smart_acan/logic/cubit/scan_cubit.dart';
import 'package:sakeena_app/features/smart_acan/ui/view/widgets/analyze_button.dart';
import 'package:sakeena_app/features/smart_acan/ui/view/widgets/capture_image_button.dart';
import 'package:sakeena_app/features/smart_acan/ui/view/widgets/medical_disclaimer_card.dart';
import 'package:sakeena_app/features/smart_acan/ui/view/widgets/scan_header.dart';
import 'package:sakeena_app/features/smart_acan/ui/view/widgets/scan_history_button.dart';
import 'package:sakeena_app/features/smart_acan/ui/view/widgets/upload_card.dart';
import 'camera_preview_screen.dart';

class SmartScanViewBody extends StatefulWidget {
  const SmartScanViewBody({super.key});

  @override
  State<SmartScanViewBody> createState() => _SmartScanViewBodyState();
}

class _SmartScanViewBodyState extends State<SmartScanViewBody> {
  final _permissionService = PermissionService();
  final _imagePicker = ImagePicker();
  File? _capturedImage;
  bool _isPickingFromGallery = false;

  Future<void> _onCaptureTapped() async {
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

    final File? result = await Navigator.push<File>(
      context,
      MaterialPageRoute(builder: (_) => const CameraPreviewScreen()),
    );

    if (result != null && mounted) {
      setState(() => _capturedImage = result);
    }
  }

  Future<void> _pickFromGallery() async {
    if (_isPickingFromGallery) return;
    setState(() => _isPickingFromGallery = true);

    try {
      final XFile? picked = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 90,
      );
      if (picked != null && mounted) {
        setState(() => _capturedImage = File(picked.path));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('فشل رفع الصورة: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isPickingFromGallery = false);
    }
  }

  void _analyzeImage() {
    if (_capturedImage == null) return;
    context.read<ScanCubit>().predict(_capturedImage!);
  }

  void _onScanHistoryTapped() {
    context.push(AppRouter.kExamHistoryScreen);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ScanCubit, ScanState>(
      listener: (context, state) {
        if (state is ScanError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
        if (state is ScanSuccess) {
          context.push(AppRouter.kscanResultScreen, extra: state.result);
        }
      },
      builder: (context, state) {
        final isLoading = state is ScanLoading;

        return Stack(
          children: [
            ListView(
              children: [
                const ScanHeader(),
                SizedBox(height: 24.h),

                if (_capturedImage != null) ...[
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16.r),
                        child: Image.file(
                          _capturedImage!,
                          height: 250.h,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 8.h,
                        left: 8.w,
                        child: GestureDetector(
                          onTap: isLoading
                              ? null
                              : () => setState(() => _capturedImage = null),
                          child: Container(
                            padding: EdgeInsets.all(6.w),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.5),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 20.sp,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                ] else ...[
                  UploadCard(
                    onTap: _isPickingFromGallery ? null : _pickFromGallery,
                    isLoading: _isPickingFromGallery,
                  ),
                  SizedBox(height: 12.h),
                ],

                CaptureImageButton(
                  onPressed: isLoading ? null : _onCaptureTapped,
                ),
                SizedBox(height: 12.h),

                // ── سجل الفحوصات ──────────────────────────────────────
                ScanHistoryButton(
                  onPressed: isLoading ? null : _onScanHistoryTapped,
                ),
                SizedBox(height: 16.h),

                if (_capturedImage != null)
                  AnalyzeButton(onPressed: isLoading ? null : _analyzeImage),

                SizedBox(height: 16.h),
                const MedicalDisclaimerCard(),
              ],
            ),

            if (isLoading)
              SizedBox.expand(
                child: ColoredBox(
                  color: Colors.black.withValues(alpha: 0.4),
                  child: const Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularProgressIndicator(color: Colors.white),
                        SizedBox(height: 16),
                        Text(
                          'جاري تحليل الصورة...',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Cairo',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
