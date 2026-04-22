import 'package:flutter/material.dart';
import 'package:sakeena_app/features/account/data/models/user_profile_model.dart';
import 'package:sakeena_app/features/account/presentation/view/widgets/custom_user_image.dart';

class ProfileHeaderWidget extends StatelessWidget {
  const ProfileHeaderWidget({super.key, this.onTap, required this.user});

  final void Function()? onTap;
  final UserProfileModel user;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomUserImage(onTap: onTap),

        const SizedBox(height: 12),

        Text(
          '${user.firstName} ${user.lastName}',
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 4),

        Text(
          user.email,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 13, color: Colors.grey),
        ),
      ],
    );
  }
}
