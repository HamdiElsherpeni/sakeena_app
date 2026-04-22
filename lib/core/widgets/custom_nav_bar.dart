import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sakeena_app/core/utils/app_router.dart';

class CustomNavBar extends StatelessWidget {
  final int currentIndex;

  CustomNavBar({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80.h,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 70.h,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                NavItem(
                  icon: Icons.person,
                  label: "حسابي",
                  isSelected: currentIndex == 0,
                  onTap: () {
                    if (currentIndex != 0) {
                      context.go(AppRouter.kprofileview);
                    }
                  },
                ),
                NavItem(
                  icon: Icons.menu_book,
                  label: "تعليم",
                  isSelected: currentIndex == 1,
                  onTap: () {},
                ),
                SizedBox(width: 50.w),
                NavItem(
                  icon: Icons.crop_free,
                  label: "فحص",
                  isSelected: currentIndex == 2,
                  onTap: () {
                    if (currentIndex != 2) {
                      context.go(AppRouter.kSmartAcanView);
                    }
                  },
                ),
                NavItem(
                  icon: Icons.home,
                  label: "الرئيسية",
                  isSelected: currentIndex == 3,
                  onTap: () {
                    if (currentIndex != 3) {
                      context.go(AppRouter.khomeView);
                    }
                  },
                ),
              ],
            ),
          ),

          Positioned(
            top: -25,
            left: 0.w,
            right: 0.w,
            child: Center(
              child: Container(
                height: 60.h,
                width: 60.w,
                decoration: BoxDecoration(
                  color: currentIndex == 4
                      ? Colors.pink
                      : Colors.pink.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.edit, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  NavItem({
    super.key,
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: isSelected ? Colors.pink : Colors.black38),
          SizedBox(height: 5.h),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              color: isSelected ? Colors.pink : Colors.black38,
            ),
          ),
        ],
      ),
    );
  }
}
