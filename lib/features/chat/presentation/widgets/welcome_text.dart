import 'package:flutter/material.dart';
import 'package:sakeena_app/features/chat/presentation/widgets/gradient_text.dart';

class WelcomeText extends StatelessWidget {
  const WelcomeText({super.key});

  @override
  Widget build(BuildContext context) {
    return const GradientText(
      text: 'Welcome to Sakeena',
      style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
      gradient: LinearGradient(
        colors: [Colors.blue, Colors.red],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    );
  }
}
