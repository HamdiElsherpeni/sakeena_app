import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sakeena_app/core/app/sakeena_app.dart';
import 'package:sakeena_app/core/di/service_locator.dart';
import 'package:sakeena_app/core/utils/app_router.dart';
import 'package:sakeena_app/core/services/notification_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setupServiceLocator();

  // ✅ لازم تشغيل الإشعارات هنا
  await NotificationService.init();

  // ✅ مسح الداتا القديمة عند تحديث نسخة التطبيق
  await _clearDataOnVersionChange();

  AppRouter.router();
  runApp(const MyApp());
}

/// يتحقق من نسخة التطبيق — لو اتغيرت يمسح SharedPreferences
Future<void> _clearDataOnVersionChange() async {
  const String versionKey = 'app_version';
  final prefs = await SharedPreferences.getInstance();

  try {
    final info = await PackageInfo.fromPlatform();
    final currentVersion = '${info.version}+${info.buildNumber}';
    final savedVersion = prefs.getString(versionKey);

    if (savedVersion != currentVersion) {
      await prefs.clear();
      await prefs.setString(versionKey, currentVersion);

      debugPrint(
        '🔄 Version changed ($savedVersion → $currentVersion): SharedPreferences cleared',
      );
    } else {
      debugPrint('✅ Same version ($currentVersion): SharedPreferences kept');
    }
  } catch (e) {
    debugPrint('⚠️ Could not check app version: $e');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return const SakeenaApp();
      },
    );
  }
}
