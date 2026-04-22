import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakeena_app/core/di/service_locator.dart';
import 'package:sakeena_app/core/resources/app_colors.dart';
import 'package:sakeena_app/features/account/logic/cubit/account_cubit.dart';
import 'package:sakeena_app/features/account/presentation/view/widgets/change_poassword_view_body.dart';

class ChangePasswordView extends StatelessWidget {
  ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AccountCubit>(),
      child: Scaffold(
        backgroundColor: AppColors.kprimaryColor,
        body: SafeArea(child: ChangePasswordViewBody()),
      ),
    );
  }
}
