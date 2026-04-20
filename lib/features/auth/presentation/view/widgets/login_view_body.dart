import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sakeena_app/core/utils/app_router.dart';
import 'package:sakeena_app/core/resources/app_colors.dart';
import 'package:sakeena_app/core/widgets/coustem_eleveted_butten.dart';
import 'package:sakeena_app/features/auth/logic/auth_cubit.dart';
import 'package:sakeena_app/features/auth/logic/auth_state.dart';
import 'log_in_form.dart';
import 'package:sakeena_app/features/auth/presentation/view/widgets/custom_circle_avatar.dart';
import 'package:sakeena_app/features/auth/presentation/view/widgets/custom_googel_button.dart';
import 'package:sakeena_app/features/auth/presentation/view/widgets/custom_login_wellcom_text.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  String email = "";
  String password = "";
  bool isValid = false;

  void _onChanged(String e, String p, bool v) {
    setState(() {
      email = e;
      password = p;
      isValid = v;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          context.go(AppRouter.khomeView); // ✅ روح للهوم بعد اللوجين
        }
        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;

        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomCircleAvatar(),
              const SizedBox(height: 10),
              const CustomLoginWellcomText(),
              const SizedBox(height: 30),

              LogInForm(onChanged: _onChanged),

              const SizedBox(height: 20),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => context.push(AppRouter.kforgetView),
                  child: Text(
                    'هل نسيت كلمة السر؟',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              CoustemElevetedBoutten(
                text: isLoading ? 'جاري تسجيل الدخول...' : 'تسجيل الدخول',
                backgroundcolor: isValid ? AppColors.primary : Colors.grey,
                height: 60,
                onPressed: (!isValid || isLoading)
                    ? null
                    : () {
                        context.read<AuthCubit>().login(
                          email: email,
                          password: password,
                        );
                      },
              ),

              const SizedBox(height: 30),

              const CustomGoogelButton(),
            ],
          ),
        );
      },
    );
  }
}
