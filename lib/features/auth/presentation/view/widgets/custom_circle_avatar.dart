import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sakeena_app/core/resources/app_colors.dart';

class CustomCircleAvatar extends StatelessWidget {
  const CustomCircleAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return  CircleAvatar(
            radius: 21,
            child: CircleAvatar(
              radius: 20,
              backgroundColor: AppColors.KprimaryColor,
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