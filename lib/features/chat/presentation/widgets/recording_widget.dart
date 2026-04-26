import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class RecordingWidget extends StatelessWidget {
  const RecordingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 130),
      width: double.infinity,
      height: 120,
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(200),
      ),
      child: Lottie.asset('assets/lottie/mic.json'),
    );
  }
}
