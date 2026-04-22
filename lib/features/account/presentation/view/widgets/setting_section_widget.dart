import 'package:flutter/material.dart';
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
        const Padding(
          padding: EdgeInsets.only(bottom: 12, right: 4),
          child: Text(
            'الإعدادات',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D2D2D),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _items.length,
            separatorBuilder: (_, __) => const Divider(
              height: 1,
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
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: const Color(0xFFF9F0F3),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  item.icon,
                  color: const Color(0xFFB5456A),
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                item.label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: Color.fromARGB(255, 4, 4, 4),
                ),
              ),
            ],
          ),
          const Icon(Icons.chevron_right, color: Colors.black, size: 20),
        ],
      ),
    );
  }
}
