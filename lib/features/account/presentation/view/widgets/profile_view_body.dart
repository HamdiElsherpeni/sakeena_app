import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:sakeena_app/core/utils/app_router.dart';
import 'package:sakeena_app/features/account/logic/cubit/account_cubit.dart';
import 'package:sakeena_app/features/account/logic/cubit/account_state.dart';

import 'package:sakeena_app/features/account/presentation/view/widgets/logout_button_widget.dart';
import 'package:sakeena_app/features/account/presentation/view/widgets/notifications_toggel_widget.dart';
import 'package:sakeena_app/features/account/presentation/view/widgets/profile_header_widget.dart';
import 'package:sakeena_app/features/account/presentation/view/widgets/setting_section_widget.dart';

class ProfileViewBody extends StatelessWidget {
  ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9F5F2),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 24,
                ),
                child: Column(
                  children: [
                    BlocBuilder<AccountCubit, AccountState>(
                      builder: (context, state) {
                        if (state is AccountLoading) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is ProfileLoaded ||
                            state is ProfileUpdated) {
                          final profile = state is ProfileLoaded
                              ? state.profile
                              : (state as ProfileUpdated).profile;

                          return ProfileHeaderWidget(
                            onTap: () {
                              GoRouter.of(
                                context,
                              ).push(AppRouter.kprofileditview);
                            },
                            user: profile,
                          );
                        } else if (state is AccountError) {
                          return Text(state.message);
                        }

                        return SizedBox();
                      },
                    ),
                    SizedBox(height: 24.h),
                    NotificationsToggleWidget(),
                    SizedBox(height: 24.h),
                    SettingsSectionWidget(),
                    SizedBox(height: 24.h),
                    LogoutButtonWidget(),
                    SizedBox(height: 16.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
