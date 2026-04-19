import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:sakeena_app/core/app/sakeena_app.dart';
import 'package:sakeena_app/core/database/my_cache_helper.dart';
import 'package:sakeena_app/core/database/prefs_constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final seenOnBoarding =
      await SharedPrefHelper.getBool(PrefsConstants.onBoarding) ?? false;

  runApp(MyApp(seenOnBoarding: seenOnBoarding));
}

/// Wrapper مهم لـ ScreenUtil
class MyApp extends StatelessWidget {
  final bool seenOnBoarding;

  const MyApp({super.key, required this.seenOnBoarding});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return SakeenaApp(
          seenOnBoarding: seenOnBoarding,
        );
      },
    );
  }
}