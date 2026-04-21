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
  bool _isObscure = true;

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _register() {
    context.read<AuthCubit>().register(
      firstName: _firstNameController.text.trim(), // ✅ trim
      lastName: _lastNameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text, // ✅ الباسورد من غير trim
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
            firstNameController: _firstNameController,
            lastNameController: _lastNameController,
            emailController: _emailController,
            passwordController: _passwordController,
            isObscure: _isObscure,
            toggleObscure: () => setState(() => _isObscure = !_isObscure),
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
