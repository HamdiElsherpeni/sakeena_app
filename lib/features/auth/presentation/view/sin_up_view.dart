import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sakeena_app/core/di/service_locator.dart';
import 'package:sakeena_app/core/resources/app_colors.dart';
import 'package:sakeena_app/core/utils/app_router.dart';
import 'package:sakeena_app/features/auth/logic/auth_cubit.dart';
import 'package:sakeena_app/features/auth/logic/auth_state.dart';
import 'package:sakeena_app/features/auth/presentation/view/widgets/sin_up_view_body.dart';

class SinUpView extends StatelessWidget {
  const SinUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AuthCubit>(), // ✅ من getIt مباشرة
      child: const Scaffold(
        backgroundColor: AppColors.KprimaryColor,
        body: SafeArea(
          child: _SinUpViewContent(), // ✅ الـ logic منقولة للـ widget
        ),
      ),
    );
  }
}

class _SinUpViewContent extends StatelessWidget {
  const _SinUpViewContent();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }

        if (state is AuthSuccess) {
          _showSuccessDialog(context);
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;

        return Stack(
          children: [
            SinUpViewBody(isLoading: isLoading),

            if (isLoading)
              Container(
                color: Colors.black.withOpacity(0.4),
                child: const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              ),
          ],
        );
      },
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.check_circle, color: Colors.green, size: 70),
              SizedBox(height: 10),
              Text(
                "تم إنشاء الحساب بنجاح 🎉",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );

    Future.delayed(const Duration(seconds: 2), () {
      if (context.mounted) {
        Navigator.pop(context);
        context.go(AppRouter.kLogin);
      }
    });
  }
}
