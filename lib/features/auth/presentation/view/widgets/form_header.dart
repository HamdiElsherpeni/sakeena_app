import 'package:flutter/material.dart';

class FormHeader extends StatelessWidget {
  final String title;

  const FormHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    );
  }
}
