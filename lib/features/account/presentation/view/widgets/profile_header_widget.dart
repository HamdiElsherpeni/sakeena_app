import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakeena_app/features/account/data/models/user_profile_model.dart';
import 'package:sakeena_app/features/account/presentation/view/widgets/custom_user_image.dart';

class ProfileHeaderWidget extends StatelessWidget {
  const ProfileHeaderWidget({super.key, required this.user});

  final UserProfileModel user;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomUserImage(),
        SizedBox(height: 12.h),
        Text(
          '${user.firstName} ${user.lastName}',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4.h),
        Text(
          user.email,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 13.sp, color: Colors.grey),
        ),
      ],
    );
  }
}