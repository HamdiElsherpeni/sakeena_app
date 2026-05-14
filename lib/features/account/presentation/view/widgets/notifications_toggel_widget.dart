import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sakeena_app/core/services/notification_service.dart';

class NotificationsToggleWidget extends StatefulWidget {
  const NotificationsToggleWidget({super.key});

  @override
  State<NotificationsToggleWidget> createState() =>
      _NotificationsToggleWidgetState();
}

class _NotificationsToggleWidgetState extends State<NotificationsToggleWidget> {
  bool _notificationsOn = true;

  static const _prefKey = 'notifications_enabled';

  @override
  void initState() {
    super.initState();
    _loadPref();
  }

  Future<void> _loadPref() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      _notificationsOn = prefs.getBool(_prefKey) ?? true;
    });
  }

  Future<void> _toggle(bool val) async {
    setState(() => _notificationsOn = val);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_prefKey, val);

    if (val) {
      await NotificationService.scheduleMonthlyReminder();
    } else {
      await NotificationService.cancelReminder();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.17),
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 36.w,
            height: 36.h,
            decoration: BoxDecoration(
              color: const Color(0xFFF9F0F3),
              borderRadius: BorderRadius.circular(40.r),
            ),
            child: Icon(
              _notificationsOn
                  ? Icons.notifications_on_outlined
                  : Icons.notifications_off_outlined,
              color: const Color(0xFFB5456A),
              size: 20,
            ),
          ),
          Text(
            'الإشعارات',
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF2D2D2D),
            ),
          ),
          Switch(
            value: _notificationsOn,
            onChanged: _toggle,
            activeColor: const Color(0xFFB5456A),
            activeTrackColor: const Color(0xFFE8A0B4),
          ),
        ],
      ),
    );
  }
}
