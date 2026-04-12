import 'package:flutter/material.dart';
import 'package:sakeena_app/core/app/sakeena_app.dart';
import 'package:sakeena_app/core/database/my_cache_helper.dart';
import 'package:sakeena_app/core/database/prefs_constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  bool seenOnBoarding = await SharedPrefHelper.getBool(PrefsConstants.onBoarding);
  
  runApp(SakeenaApp(seenOnBoarding: seenOnBoarding));
}