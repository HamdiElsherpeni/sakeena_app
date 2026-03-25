import 'package:flutter/material.dart';
import 'package:sakeena_app/core/resources/app_colors.dart';

class CoustemTextFormFailed extends StatelessWidget {
  const CoustemTextFormFailed({
    super.key,
    required this.hent,
    this.sufixIcon,
    this.obscure,
    this.onChanged,
    this.onFieldSubmitted,
    this.validator,
    this.leble,
    this.controller,
    this.height, // ارتفاع اختياري
  });

  final String hent;
  final String? leble;
  final bool? obscure;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final IconButton? sufixIcon;
  final double? height; // ارتفاع الحقل

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 60, // ارتفاع افتراضي 60
      child: TextFormField(
        controller: controller,
        validator: validator ??
            (vall) {
              if (vall == null || vall.isEmpty) {
                return "This field is required";
              }
              return null;
            },
        onChanged: onChanged,
        onFieldSubmitted: onFieldSubmitted,
        obscureText: obscure ?? false,
        style: const TextStyle(color: Colors.black, fontSize: 14),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white, // خلفية بيضاء
          contentPadding: const EdgeInsets.symmetric(
            vertical: 18, // يزيد ارتفاع الحقل
            horizontal: 12,
          ),
          hintText: hent,
          hintStyle: const TextStyle(color: Colors.grey),
          labelText: leble,
          labelStyle: const TextStyle(color: Colors.grey),
          suffixIcon: sufixIcon,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primary, width: 1),
            borderRadius: BorderRadius.circular(5),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.blueAccent, width: 1.5),
            borderRadius: BorderRadius.circular(5),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red, width: 1),
            borderRadius: BorderRadius.circular(5),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red, width: 1.5),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    );
  }
}