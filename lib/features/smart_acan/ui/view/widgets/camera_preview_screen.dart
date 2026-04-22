import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakeena_app/core/services/camera_service.dart';

class CameraPreviewScreen extends StatefulWidget {
  const CameraPreviewScreen({super.key});

  @override
  State<CameraPreviewScreen> createState() => _CameraPreviewScreenState();
}

class _CameraPreviewScreenState extends State<CameraPreviewScreen> {
  final CameraService _cameraService = CameraService();
  bool _isInitializing = true;
  bool _isCapturing = false;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    try {
      await _cameraService.initialize();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('فشل تشغيل الكاميرا: $e'),
            backgroundColor: Colors.red,
          ),
        );
        Navigator.pop(context);
      }
      return;
    }
    if (mounted) setState(() => _isInitializing = false);
  }

  Future<void> _capture() async {
    if (_isCapturing) return;
    setState(() => _isCapturing = true);

    try {
      final File? photo = await _cameraService.capturePhoto();

      if (photo != null && mounted) {
        final Size screenSize = MediaQuery.of(context).size;
        final File? cropped = await _cameraService.cropCapturedImage(
          imageFile: photo,
          screenSize: screenSize,
          frameSize: const Size(300, 300),
        );
        if (mounted) Navigator.pop(context, cropped ?? photo);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('حدث خطأ: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _isCapturing = false);
    }
  }

  @override
  void dispose() {
    _cameraService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _isInitializing
          ? const Center(child: CircularProgressIndicator(color: Colors.white))
          : Stack(
              fit: StackFit.expand,
              children: [
                // معاينة الكاميرا كاملة
                CameraPreview(_cameraService.controller!),

                // زرار الرجوع
                Positioned(
                  top: 50.h,
                  right: 16.w,
                  child: SafeArea(
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ),

                // زرار الفلاش
                Positioned(
                  top: 50.h,
                  left: 16.w,
                  child: SafeArea(
                    child: IconButton(
                      onPressed: () async {
                        await _cameraService.toggleFlashMode();
                        setState(() {});
                      },
                      icon: Icon(
                        switch (_cameraService.flashMode) {
                          FlashMode.off => Icons.flash_off,
                          FlashMode.auto => Icons.flash_auto,
                          _ => Icons.flash_on,
                        },
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  ),
                ),

                // زرار الالتقاط في الأسفل
                Positioned(
                  bottom: 48.h,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: GestureDetector(
                      onTap: _isCapturing ? null : _capture,
                      child: Container(
                        width: 72.w,
                        height: 72.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 4),
                          color: _isCapturing
                              ? Colors.grey
                              : Colors.white.withValues(alpha: 0.9),
                        ),
                        child: _isCapturing
                            ? const CircularProgressIndicator(
                                color: Colors.black,
                                strokeWidth: 2,
                              )
                            : const Icon(
                                Icons.camera_alt,
                                color: Colors.black,
                                size: 32,
                              ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
