import 'package:flutter/material.dart';

class NotificationsToggleWidget extends StatefulWidget {
  const NotificationsToggleWidget({super.key});

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
  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
  decoration: BoxDecoration(
    color: Colors.grey.withOpacity(0.17),
    borderRadius: BorderRadius.circular(30),
  ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Bell icon
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: const Color(0xFFF9F0F3),
              borderRadius: BorderRadius.circular(40),
            ),
            child: const Icon(Icons.notifications_on_outlined,
                color: Color(0xFFB5456A), size: 20),
          ),
          // Label (RTL)
          const Text(
            'الإشعارات',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Color(0xFF2D2D2D),
            ),
          ),
          // Toggle
          Switch(
            value: _notificationsOn,
            onChanged: (val) => setState(() => _notificationsOn = val),
            activeColor: const Color(0xFFB5456A),
            activeTrackColor: const Color(0xFFE8A0B4),
          ),
        ],
      ),
    );
  }
}