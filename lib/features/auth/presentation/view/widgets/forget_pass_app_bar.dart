import 'package:flutter/material.dart';
import 'package:sakeena_app/features/auth/presentation/view/widgets/custom_circle_avatar.dart';

class ForgetPassAppBar extends StatelessWidget {
  const ForgetPassAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomCircleAvatar(),
        SizedBox(width: 60),
        Text(
          'نسيت الباسوورد',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
        ),
      
      ],
    );
  }
}
