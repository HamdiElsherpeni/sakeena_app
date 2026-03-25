import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CoustemElevetedBoutten extends StatelessWidget {
  const CoustemElevetedBoutten({
    super.key,
    this.onPressed,
    required this.text,
    this.backgroundcolor,
    this.height,
    this.fontSize,
    this.textcolor,
  });

  final void Function()? onPressed;
  final String text;
  final Color? backgroundcolor;
  final Color? textcolor;
  final double? height; // ارتفاع متجاوب
  final double? fontSize; // حجم نص متجاوب

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: height ?? 50, // ارتفاع افتراضي 50.h
            child: ElevatedButton(
              onPressed: onPressed,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  backgroundcolor ?? const Color.fromARGB(255, 74, 57, 226),
                ),
                foregroundColor: MaterialStateProperty.all(Colors.white),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(
                      color: Colors.grey, // لون البوردر
                      width: 1.5, // سمك البوردر
                    ),
                  ),
                ),
              ),
              child: Text(
                text,
                style: TextStyle(
                  color: textcolor ?? Colors.white,
                  fontSize: fontSize ?? 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Rubik',
                ), // متجاوب
              ),
            ),
          ),
        ),
      ],
    );
  }
}
