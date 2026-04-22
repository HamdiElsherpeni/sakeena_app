import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sakeena_app/core/utils/app_router.dart';
import 'package:sakeena_app/core/resources/app_colors.dart';
import 'package:sakeena_app/core/widgets/coustem_eleveted_butten.dart';
import 'package:sakeena_app/features/auth/logic/auth_cubit.dart';
import 'log_in_form.dart';
import 'package:sakeena_app/core/widgets/custom_circle_avatar.dart';
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
        if (state is LoginSuccess) {
          // ✅ بدل state.token بقت state.user.token
          // print("LOGIN TOKEN: ${state.user.token}");
          // print("USER NAME: ${state.user.user.user.fullName}");
          context.go(AppRouter.kSplash);
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
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomCircleAvatar(),
              SizedBox(height: 10.h),
              CustomLoginWellcomText(),
              SizedBox(height: 30.h),

              LogInForm(onChanged: _onChanged),

              SizedBox(height: 20.h),

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

              SizedBox(height: 20.h),

              CoustemElevetedBoutten(
                text: isLoading ? 'جاري تسجيل الدخول...' : 'تسجيل الدخول',
                backgroundcolor: isValid ? AppColors.primary : Colors.grey,
                height: 60.h,
                onPressed: (!isValid || isLoading)
                    ? null
                    : () {
                        context.read<AuthCubit>().login(
                          email: email,
                          password: password,
                        );
                      },
              ),

              SizedBox(height: 30.h),

              CustomGoogelButton(),
            ],
          ),
        );
      },
    );
  }
}
