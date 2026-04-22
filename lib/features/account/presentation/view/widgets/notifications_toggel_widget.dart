import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationsToggleWidget extends StatefulWidget {
  NotificationsToggleWidget({super.key});

  @override
  State<NotificationsToggleWidget> createState() =>
      _NotificationsToggleWidgetState();
}

class _NotificationsToggleWidgetState
    extends State<NotificationsToggleWidget> {
  bool _notificationsOn = true;

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
          // Bell icon
          Container(
            width: 36.w,
            height: 36.h,
            decoration: BoxDecoration(
              color: Color(0xFFF9F0F3),
              borderRadius: BorderRadius.circular(40.r),
            ),
            child: Icon(Icons.notifications_on_outlined,
                color: Color(0xFFB5456A), size: 20),
          ),
          // Label (RTL)
          Text(
            'الإشعارات',
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
              color: Color(0xFF2D2D2D),
            ),
          ),
          // Toggle
          Switch(
            value: _notificationsOn,
            onChanged: (val) => setState(() => _notificationsOn = val),
            activeColor: Color(0xFFB5456A),
            activeTrackColor: Color(0xFFE8A0B4),
          ),
        ],
      ),
    );
  }
}