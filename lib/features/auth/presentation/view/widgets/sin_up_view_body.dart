import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakeena_app/features/auth/logic/auth_cubit.dart';
import 'package:sakeena_app/core/widgets/custom_circle_avatar.dart';
import 'package:sakeena_app/features/auth/presentation/view/widgets/custom_googel_button.dart';
import 'package:sakeena_app/features/auth/presentation/view/widgets/custom_wellcome_text_sin_up.dart';
import 'package:sakeena_app/features/auth/presentation/view/widgets/sin_up_form.dart';

class SinUpViewBody extends StatefulWidget {
  final bool isLoading;

  const SinUpViewBody({super.key, required this.isLoading});

  @override
  State<SinUpViewBody> createState() => _SinUpViewBodyState();
}

class _SinUpViewBodyState extends State<SinUpViewBody> {
  bool isObscure = true;

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _register() {
    context.read<AuthCubit>().register(
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      email: emailController.text,
      password: passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomCircleAvatar(),
          const SizedBox(height: 10),

          const CustomWellcomeTextSinUp(),
          const SizedBox(height: 30),

          SinUpForm(
            firstNameController: firstNameController,
            lastNameController: lastNameController,
            emailController: emailController,
            passwordController: passwordController,
            isObscure: isObscure,
            toggleObscure: () {
              setState(() {
                isObscure = !isObscure;
              });
            },
            onRegister: _register,
            isLoading: widget.isLoading,
          ),

          const SizedBox(height: 30),

          const CustomGoogelButton(),
        ],
      ),
    );
  }
}
