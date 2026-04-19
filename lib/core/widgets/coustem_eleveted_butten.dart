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
    this.isLoading = false,
  });

  final VoidCallback? onPressed;
  final String text;
  final Color? backgroundcolor;
  final Color? textcolor;
  final double? height;
  final double? fontSize;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: (height ?? 50).h,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor:
              backgroundcolor ?? const Color.fromARGB(255, 74, 57, 226),
          disabledBackgroundColor: Colors.grey.shade400,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
            side: const BorderSide(
              color: Colors.grey,
              width: 1.5,
            ),
          ),
        ),
        child: isLoading
            ? SizedBox(
                height: 22.h,
                width: 22.h,
                child: const CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : Text(
                text,
                style: TextStyle(
                  color: textcolor ?? Colors.white,
                  fontSize: (fontSize ?? 20).sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Rubik',
                ),
              ),
      ),
    );
  }
}