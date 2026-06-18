import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sakeena_app/core/resources/app_assets.dart';
import 'package:sakeena_app/core/resources/app_colors.dart';

class CustomUserImage extends StatefulWidget {
  const CustomUserImage({super.key});

  @override
  State<CustomUserImage> createState() => _CustomUserImageState();
}

class _CustomUserImageState extends State<CustomUserImage> {
  File? _pickedImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _pickedImage = File(picked.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        CircleAvatar(
          radius: 49.r,
          backgroundColor: AppColors.primary,
          child: CircleAvatar(
            radius: 48.r,
            backgroundColor: AppColors.kprimaryColor,
            backgroundImage: _pickedImage != null
                ? FileImage(_pickedImage!)
                : AssetImage("assets/images/un.png") as ImageProvider,
          ),
        ),
        GestureDetector(
          onTap: _pickImage,
          child: Container(
            width: 28.w,
            height: 28.h,
            decoration: BoxDecoration(
              color: const Color(0xFFB5456A),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2.w),
            ),
            child: Icon(Icons.edit, color: Colors.white, size: 14),
          ),
        ),
      ],
    );
  }
}