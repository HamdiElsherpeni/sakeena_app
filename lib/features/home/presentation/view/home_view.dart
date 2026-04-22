import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakeena_app/core/di/service_locator.dart';
import 'package:sakeena_app/core/resources/app_colors.dart';
import 'package:sakeena_app/features/account/logic/cubit/account_cubit.dart';
import 'widgets/home_view_body.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final AccountCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = getIt<AccountCubit>();
    cubit.getProfile(); // ✅ مرة واحدة بس
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: Scaffold(
        backgroundColor: AppColors.kprimaryColor,
        body: SafeArea(child: HomeViewBody()),
      ),
    );
  }
}
