import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sakeena_app/core/resources/app_colors.dart';

class CustomCircleAvatar extends StatelessWidget {
  CustomCircleAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 21.r,
      child: CircleAvatar(
        radius: 20.r,
        backgroundColor: AppColors.kprimaryColor,
        child: IconButton(
          onPressed: () {
            GoRouter.of(context).pop();
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
    );
  }
}
