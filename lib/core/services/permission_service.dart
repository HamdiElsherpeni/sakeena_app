import 'package:permission_handler/permission_handler.dart';

enum AppPermission { camera, location }

extension AppPermissionExtension on AppPermission {
  String get arabicName => switch (this) {
    AppPermission.camera => 'الكاميرا',
    AppPermission.location => 'الموقع',
  };

  String get arabicDescription => switch (this) {
    AppPermission.camera => 'عشان تقدر تلتقطي صور للأشعة',
    AppPermission.location => 'عشان نعرف مكانك بدقة',
  };
}

class PermissionService {
  static final PermissionService _instance = PermissionService._internal();
  factory PermissionService() => _instance;
  PermissionService._internal();

  Future<Map<AppPermission, bool>> requestAllPermissions() async {
    final results = await [
      Permission.camera,
      Permission.locationWhenInUse,
    ].request();

    return {
      AppPermission.camera:
          results[Permission.camera] == PermissionStatus.granted,
      AppPermission.location:
          results[Permission.locationWhenInUse] == PermissionStatus.granted,
    };
  }

  Future<bool> check(AppPermission permission) async {
    final status = await _toSystemPermission(permission).status;
    return status == PermissionStatus.granted;
  }

  Future<bool> request(AppPermission permission) async {
    final status = await _toSystemPermission(permission).request();
    return status == PermissionStatus.granted;
  }

  Future<bool> isPermanentlyDenied(AppPermission permission) async {
    final status = await _toSystemPermission(permission).status;
    return status == PermissionStatus.permanentlyDenied;
  }

  Future<void> openSettings() => openAppSettings();

  Permission _toSystemPermission(AppPermission permission) =>
      switch (permission) {
        AppPermission.camera => Permission.camera,
        AppPermission.location => Permission.locationWhenInUse,
      };
}
