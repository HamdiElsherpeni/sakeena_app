import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakeena_app/core/di/service_locator.dart';
import 'package:sakeena_app/core/resources/app_colors.dart';
import 'package:sakeena_app/features/auth/data/repositories/auth_repository.dart';
import 'package:sakeena_app/features/auth/logic/auth_cubit.dart';
import 'package:sakeena_app/features/auth/presentation/view/widgets/login_view_body.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthCubit(getIt<AuthRepository>()),
      child: const Scaffold(
        backgroundColor: AppColors.KprimaryColor,
        body: SafeArea(child: LoginViewBody()),
      ),
    );
  }
}
