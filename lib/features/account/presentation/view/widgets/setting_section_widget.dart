import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sakeena_app/core/utils/app_router.dart';

class _SettingsItem {
  final IconData icon;
  final String label;
  final String? route;

  const _SettingsItem({required this.icon, required this.label, this.route});
}

class SettingsSectionWidget extends StatelessWidget {
  const SettingsSectionWidget({super.key});

  static final List<_SettingsItem> _items = [
    _SettingsItem(
      icon: Icons.person_outline,
      label: 'تعديل الملف الشخصي',
      route: AppRouter.kprofileditview,
    ),
    _SettingsItem(
      icon: Icons.lock_outline,
      label: 'تغيير كلمة المرور',
      route: AppRouter.kchangePasswordview,
    ),
    _SettingsItem(icon: Icons.headset_mic_outlined, label: 'التواصل والدعم'),
    _SettingsItem(icon: Icons.language, label: 'المصادر والمراجع'),
    _SettingsItem(icon: Icons.groups_outlined, label: 'من نحن'),
  ];

  void _pushFunction(BuildContext context, String router) {
    context.push(router);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 12.h, right: 4.w),
          child: Text(
            'الإعدادات',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D2D2D),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: _items.length,
            separatorBuilder: (_, __) => Divider(
              height: 1.h,
              indent: 20,
              endIndent: 20,
              color: Color(0xFFF0EAE6),
            ),
            itemBuilder: (context, index) {
              final item = _items[index];

              return InkWell(
                onTap: () {
                  if (item.route != null) {
                    _pushFunction(context, item.route!);
                  } else {
                    // ممكن لاحقًا تضيف actions هنا
                    debugPrint('No route for ${item.label}');
                  }
                },
                child: SettingsItemTileWidget(item: item),
              );
            },
          ),
        ),
      ],
    );
  }
}

class SettingsItemTileWidget extends StatelessWidget {
  final _SettingsItem item;

  const SettingsItemTileWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 36.w,
                height: 36.h,
                decoration: BoxDecoration(
                  color: Color(0xFFF9F0F3),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  item.icon,
                  color: Color(0xFFB5456A),
                  size: 22,
                ),
              ),
              SizedBox(width: 12.w),
              Text(
                item.label,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w800,
                  color: Color.fromARGB(255, 4, 4, 4),
                ),
              ),
            ],
          ),
          Icon(Icons.chevron_right, color: Colors.black, size: 20),
        ],
      ),
    );
  }
}
