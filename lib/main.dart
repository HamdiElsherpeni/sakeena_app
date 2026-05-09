import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakeena_app/core/app/sakeena_app.dart';
import 'package:sakeena_app/core/di/service_locator.dart';
import 'package:sakeena_app/core/services/token_service.dart';
import 'package:sakeena_app/core/utils/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();

  // ← تست مؤقت - توكن منتهي + refreshToken صح
  await TokenService.saveTokens(
    token:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjM2M3YmI2Ny0wNzgwLTRkM2MtYmFjMC00YjAyNDJjYmFjOTQiLCJlbWFpbCI6ImlnYXdzNDc2NjRAbWluaXR0cy5uZXQiLCJnaXZlbl9uYW1lIjoid210IiwiZmFtaWx5X25hbWUiOiJtb2h3bWVkIiwianRpIjoiMjNlMzg0NjAtYTUzNi00ZTFlLWIzMzEtODEwM2I4NGU5MmM4IiwiZXhwIjoxNzc4MzY1OTI4LCJpc3MiOiJCcmVzdENhbnNlciIsImF1ZCI6IkJyZXN0Q2Fuc2VyIHVzZXJzIn0.wHd79XRK8PydulkXw4er2KgfsXeaedB6_T_BOX_gnf4',
    refreshToken:
        'j1q/0RP04od4BFCtKx/Y1lv+AJtIaHYD5De2BghHTUP7TNaIvdGNi2fBVAIz6mg5593ETvz/zY6vCqsLGGsk/w==',
    refreshTokenExpiration: '2026-05-23T22:02:08.0091053Z',
  );
  AppRouter.router();
  runApp(const MyApp());
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
