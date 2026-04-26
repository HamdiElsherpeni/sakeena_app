import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sakeena_app/core/utils/app_router.dart';

class ChatAppBar extends StatelessWidget {
  const ChatAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () => context.go(AppRouter.khomeView),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        const Spacer(),
        const Text(
          'Sakeena',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        const SizedBox(width: 48),
      ],
    );
  }
}
