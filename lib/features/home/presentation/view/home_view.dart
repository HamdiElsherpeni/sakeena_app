import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakeena_app/core/di/service_locator.dart';
import 'package:sakeena_app/core/resources/app_colors.dart';
import 'package:sakeena_app/features/account/logic/cubit/account_cubit.dart';
import 'package:sakeena_app/features/notifications/logic/cubit/notification_cubit.dart';

import 'widgets/home_view_body.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final AccountCubit accountCubit;
  late final NotificationCubit notificationCubit;

  @override
  void initState() {
    super.initState();

    accountCubit = getIt<AccountCubit>();
    notificationCubit = getIt<NotificationCubit>();

    // 🔥 Load profile
    accountCubit.getProfile();

    // 🔥 Load notifications (important for badge)
    notificationCubit.loadNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: accountCubit),
        BlocProvider.value(value: notificationCubit),
      ],
      child: Scaffold(
        backgroundColor: AppColors.kprimaryColor,
        body: const SafeArea(child: HomeViewBody()),
      ),
    );
  }
}
