import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sakeena_app/core/resources/app_colors.dart';
import 'package:sakeena_app/core/utils/app_router.dart';

class CustomNavBar extends StatelessWidget {
  final int currentIndex;

  const CustomNavBar({super.key, required this.currentIndex});

  void _onTap(BuildContext context, int index) {
    if (index == currentIndex) return;
    switch (index) {
      case 0:
        context.go(AppRouter.khomeView);
      case 1:
        context.go(AppRouter.kSmartAcanView);
      case 2:
        context.go(AppRouter.kEducationView);
      case 3:
        context.go(AppRouter.kprofileview);
    }
  }

  void _onChatTap(BuildContext context) {
    context.go(AppRouter.kChatView);
  }

  Widget _buildNavItem(BuildContext context, int index, List<_NavItem> items) {
    final isSelected = currentIndex == index;
    return GestureDetector(
      onTap: () => _onTap(context, index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(
          horizontal: isSelected ? 18.w : 14.w,
          vertical: isSelected ? 12.h : 10.h,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color.fromARGB(255, 229, 228, 226)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(30.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: isSelected
                  ? Padding(
                      padding: EdgeInsetsDirectional.only(start: 6.w),
                      child: Text(
                        items[index].label,
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
            SizedBox(width: isSelected ? 8.w : 0),
            AnimatedScale(
              duration: Duration(
                milliseconds: index == 2 ? 700 : (index == 3 ? 500 : 600),
              ),
              scale: isSelected
                  ? (index == 2 ? 1.25 : (index == 3 ? 1.2 : 1.15))
                  : 1.0,
              curve: index == 3 ? Curves.easeInOutCubic : Curves.elasticOut,
              child: AnimatedPadding(
                duration: const Duration(milliseconds: 400),
                padding: EdgeInsets.only(
                  bottom: isSelected ? (index == 3 ? 4.h : 2.h) : 0,
                ),
                child: Icon(
                  items[index].icon,
                  color: isSelected ? Colors.black : Colors.grey,
                  size: 24.r,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final items = [
      _NavItem(icon: Icons.home_outlined, label: 'الرئيسية'),
      _NavItem(icon: Icons.crop_free, label: 'فحص'),
      _NavItem(icon: Icons.menu_book_outlined, label: 'تعليم'),

      _NavItem(icon: Icons.person_outline, label: 'حسابي'),
    ];

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        // ── الـ NavBar الأساسي ─────────────────────────────────────────
        Container(
          width: double.infinity,
          height: 85.h,
          padding: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 15.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _buildNavItem(context, 0, items), // حسابي
              _buildNavItem(context, 1, items), // تعليم
              SizedBox(width: 60.w), // ← مساحة الـ FAB
              _buildNavItem(context, 2, items), // فحص
              _buildNavItem(context, 3, items), // الرئيسية
            ],
          ),
        ),

        // ── دايرة الـ Chat البارزة في النص ────────────────────────────
        Positioned(
          top: -28.h,
          child: InkWell(
            onTap: () {
              context.go(AppRouter.kChatView);
            },
            child: Container(
              width: 48.r,
              height: 48.r,
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.white,
                    blurRadius: 14,
                    spreadRadius: 2,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(
                Icons.chat_bubble_outline_outlined,
                color: Colors.white,
                size: 26.r,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;
  const _NavItem({required this.icon, required this.label});
}
