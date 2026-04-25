import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakeena_app/constsnt.dart';
import 'package:sakeena_app/core/di/service_locator.dart';
import 'package:sakeena_app/core/resources/app_colors.dart';
import 'package:sakeena_app/features/auth/logic/auth_cubit.dart';
import 'package:sakeena_app/features/auth/presentation/view/widgets/forget_pass_view_body.dart';

class ForgetPassView extends StatelessWidget {
  const ForgetPassView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      // ✅ بدل BlocProvider
      value: getIt<AuthCubit>(), // ✅ نفس الـ singleton مش instance جديدة
      child: Scaffold(
        backgroundColor: AppColors.kprimaryColor,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: kPaading),
            child: ForgetPassViewBody(),
          ),
        ),
      ),
    );
  }
}
