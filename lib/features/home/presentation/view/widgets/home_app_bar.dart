import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakeena_app/core/resources/app_assets.dart';
import 'package:sakeena_app/core/resources/app_colors.dart';
import 'package:sakeena_app/features/account/logic/cubit/account_cubit.dart';
import 'package:sakeena_app/features/account/logic/cubit/account_state.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  Widget _skeleton() {
    return Container(
      width: 120,
      height: 18,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountCubit, AccountState>(
      builder: (context, state) {
        final cubit = context.read<AccountCubit>();
        final user = cubit.user;

        final isLoading = state is AccountLoading || user == null;

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Settings icon
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.tune, color: AppColors.primary, size: 20),
            ),

            // Name or Skeleton
            Row(
              children: [
                isLoading
                    ? _skeleton()
                    : Text(
                        'أهلا, ${user.firstName} ${user.lastName}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2D2D2D),
                        ),
                      ),
                const SizedBox(width: 8),
                Image.asset(AppAssets.logo, width: 35, height: 35),
              ],
            ),

            // Bell icon
            Stack(
              children: [
                const Icon(
                  Icons.notifications_none,
                  size: 28,
                  color: Color(0xFF2D2D2D),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
