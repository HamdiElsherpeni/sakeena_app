import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;

class CameraService {
  static final CameraService _instance = CameraService._internal();
  factory CameraService() => _instance;
  CameraService._internal();

  CameraController? _controller;
  List<CameraDescription> _cameras = [];
  int _cameraIndex = 0;
  FlashMode _flashMode = FlashMode.off;

  CameraController? get controller => _controller;
  bool get isInitialized => _controller?.value.isInitialized ?? false;
  FlashMode get flashMode => _flashMode;

  Future<void> initialize() async {
    if (_controller != null) {
      await _controller!.dispose();
      _controller = null;
    }

    _cameras = await availableCameras();
    if (_cameras.isEmpty) throw Exception('No cameras found');

    _controller = CameraController(
      _cameras[_cameraIndex],
      ResolutionPreset.high,
      enableAudio: false,
    );

    await _controller!.initialize();
    await _controller!.setFlashMode(_flashMode);
  }

  Future<void> toggleFlashMode() async {
    if (_controller == null || !isInitialized) return;

    _flashMode = switch (_flashMode) {
      FlashMode.off => FlashMode.auto,
      FlashMode.auto => FlashMode.always,
      FlashMode.always => FlashMode.off,
      _ => FlashMode.off,
    };

    await _controller!.setFlashMode(_flashMode);
  }

  Future<void> toggleCamera() async {
    if (_cameras.length < 2) return;
    _cameraIndex = (_cameraIndex + 1) % _cameras.length;
    await initialize();
  }

  Future<File?> capturePhoto() async {
    if (_controller == null || !isInitialized) return null;
    if (_controller!.value.isTakingPicture) return null;

    try {
      final XFile xFile = await _controller!.takePicture();
      return File(xFile.path);
    } catch (e) {
      debugPrint('❌ capturePhoto error: $e');
      return null;
    }
  }

  Future<File?> cropCapturedImage({
    required File imageFile,
    required Size screenSize,
    required Size frameSize,
  }) async {
    try {
      final bytes = await imageFile.readAsBytes();
      img.Image? originalImage = img.decodeImage(bytes);
      if (originalImage == null) return null;

      if (originalImage.width > originalImage.height) {
        originalImage = img.copyRotate(originalImage, angle: 90);
      }

      final double imgW = originalImage.width.toDouble();
      final double imgH = originalImage.height.toDouble();
      final double scrW = screenSize.width;
      final double scrH = screenSize.height;

      final double scale = (scrW / imgW > scrH / imgH)
          ? (scrW / imgW)
          : (scrH / imgH);

      final double visualImgW = imgW * scale;
      final double visualImgH = imgH * scale;

      final double offsetX = (visualImgW - scrW) / 2;
      final double offsetY = (visualImgH - scrH) / 2;

      final double frameXInUI = (scrW - frameSize.width) / 2;
      final double frameYInUI = (scrH - frameSize.height) / 2;

      final int x = ((frameXInUI + offsetX) / scale).round();
      final int y = ((frameYInUI + offsetY) / scale).round();
      final int width = (frameSize.width / scale).round();
      final int height = (frameSize.height / scale).round();

      final img.Image croppedImage = img.copyCrop(
        originalImage,
        x: x,
        y: y,
        width: width,
        height: height,
      );

      final List<int> croppedBytes = img.encodeJpg(croppedImage, quality: 90);
      final File croppedFile = File(
        imageFile.path.replaceAll('.jpg', '_cropped.jpg'),
      );
      await croppedFile.writeAsBytes(croppedBytes);

      return croppedFile;
    } catch (e) {
      debugPrint('❌ cropCapturedImage error: $e');
      return null;
    }
  }

  Future<void> dispose() async {
    if (_controller == null) return;
    await _controller!.dispose();
    _controller = null;
  }
}
