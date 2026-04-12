import 'package:flutter/material.dart';
import 'package:sakeena_app/core/resources/app_assets.dart';
import 'package:sakeena_app/core/resources/app_colors.dart';
import 'package:sakeena_app/features/profile_view/presentation/view/widgets/custom_user_image.dart';

class ProfileHeaderWidget extends StatelessWidget {
  const ProfileHeaderWidget({super.key, this.onTap});
final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Avatar with edit button
       CustomUserImage(onTap: onTap,),
        const SizedBox(height: 12),
        const Text(
          'سارة محمد',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2D2D2D),
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'saramohamed223@gmail.com',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 13,
            color: Color(0xFF9E9E9E),
          ),
        ),
      ],
    );
  }
}