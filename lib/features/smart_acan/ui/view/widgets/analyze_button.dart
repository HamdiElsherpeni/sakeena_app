import 'package:flutter/material.dart';
import 'package:sakeena_app/core/widgets/coustem_eleveted_butten.dart';

class AnalyzeButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isLoading;

  const AnalyzeButton({super.key, this.onPressed, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return CoustemElevetedBoutten(
      onPressed: onPressed,
      isLoading: isLoading,
      text: 'تحليل الصورة',
      backgroundcolor: Color(0xFF2ECC71), // أخضر — غيّره لأي لون تحب
    );
  }
}
