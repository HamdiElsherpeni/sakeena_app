import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakeena_app/core/resources/app_colors.dart';
import 'package:sakeena_app/features/notifications/data/repos/notification_repo.dart';
import 'package:sakeena_app/features/notifications/logic/cubit/notification_cubit.dart';
import 'package:sakeena_app/features/notifications/ui/view/widgets/notification_app_bar.dart';
import 'package:sakeena_app/features/notifications/ui/view/widgets/notification_list.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          NotificationCubit(const NotificationRepoImpl())..loadNotifications(),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: AppColors.kprimaryColor,
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: const [
                NotificationAppBar(),
                Expanded(child: NotificationList()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
