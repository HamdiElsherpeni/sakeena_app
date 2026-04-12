import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sakeena_app/core/utils/app_router.dart';

class SakeenaApp extends StatelessWidget {
  final bool seenOnBoarding;
  const SakeenaApp({super.key, required this.seenOnBoarding});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      locale: const Locale('ar'),
      supportedLocales: const [Locale('ar'), Locale('en')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routerConfig: AppRouter.router(seenOnBoarding), // ← مرره هنا
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Rubik'),
    );
  }
}