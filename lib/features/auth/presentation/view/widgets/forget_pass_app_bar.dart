import 'package:flutter/material.dart';
import 'package:sakeena_app/features/auth/presentation/view/widgets/custom_circle_avatar.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, required this.titel});
final String titel;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomCircleAvatar(),
        SizedBox(width: 60),
        Text(
         titel,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
