import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sakeena_app/core/resources/app_assets.dart';
import 'package:sakeena_app/core/utils/app_router.dart';
import 'package:sakeena_app/features/home/presentation/view/widgets/custom_nav_bar.dart';
import 'package:sakeena_app/features/profile_view/presentation/view/widgets/logout_button_widget.dart';
import 'package:sakeena_app/features/profile_view/presentation/view/widgets/notifications_toggel_widget.dart';
import 'package:sakeena_app/features/profile_view/presentation/view/widgets/profile_header_widget.dart';
import 'package:sakeena_app/features/profile_view/presentation/view/widgets/setting_section_widget.dart';

// ─────────────────────────────────────────────
//  MAIN PAGE
// ─────────────────────────────────────────────
class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F5F2),

      // 👇 حط الـ navbar هنا
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 24,
                ),
                child: Column(
                  children: [
                    ProfileHeaderWidget(
                      onTap: () {
                        GoRouter.of(context).push(AppRouter.kprofileditview);
                      },
                    ),
                    SizedBox(height: 24),
                    NotificationsToggleWidget(),
                    SizedBox(height: 24),
                    SettingsSectionWidget(),
                    SizedBox(height: 24),
                    LogoutButtonWidget(),
                    SizedBox(height: 16),
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
