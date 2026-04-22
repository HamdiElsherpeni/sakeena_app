import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakeena_app/core/resources/app_colors.dart';

class CoustemTextFormFailed extends StatelessWidget {
  CoustemTextFormFailed({
    super.key,
    required this.hent,
    this.sufixIcon,
    this.obscure,
    this.onChanged,
    this.onFieldSubmitted,
    this.validator,
    this.leble,
    this.controller,
    this.height,
    this.prefixIcon,
    this.keyboardType, // ارتفاع اختياري
  });

  final String hent;
  final String? leble;
  final bool? obscure;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final IconButton? sufixIcon;
  final Icon? prefixIcon;
  final TextInputType? keyboardType;
  final double? height; // ارتفاع الحقل

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 60, // ارتفاع افتراضي 60
      child: TextFormField(
        controller: controller,
        validator:
            validator ??
            (vall) {
              if (vall == null || vall.isEmpty) {
                return "This field is required";
              }
              return null;
            },
        onChanged: onChanged,
        onFieldSubmitted: onFieldSubmitted,
        obscureText: obscure ?? false,
        style: TextStyle(color: Colors.black, fontSize: 14.sp),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white, // خلفية بيضاء
          contentPadding: EdgeInsets.symmetric(
            vertical: 18, // يزيد ارتفاع الحقل
            horizontal: 12,
          ),
          hintText: hent,
          hintStyle: TextStyle(color: Colors.grey),
          labelText: leble,
          labelStyle: TextStyle(color: Colors.grey),
          suffixIcon: sufixIcon,
          prefix: prefixIcon,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primary, width: 1.w),
            borderRadius: BorderRadius.circular(5.r),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueAccent, width: 1.5.w),
            borderRadius: BorderRadius.circular(5.r),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 1.w),
            borderRadius: BorderRadius.circular(5.r),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 1.5.w),
            borderRadius: BorderRadius.circular(5.r),
          ),
        ),
      ),
    );
  }
}
