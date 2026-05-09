import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  NotificationService._();

  static final _plugin = FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    await _plugin.initialize(
      settings: const InitializationSettings(android: android, iOS: ios),
    );
  }

  // ─── إشعار فوري ───────────────────────────────────────────────────────────

  static Future<void> showInstant({
    required int id,
    required String title,
    required String body,
  }) async {
    await _plugin.show(
      id: id,
      title: title,
      body: body,
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          'sakeena_channel',
          'إشعارات سكينة',
          channelDescription: 'إشعارات التطبيق العامة',
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
    );
  }

  // ─── تذكير شهري ───────────────────────────────────────────────────────────

  static Future<void> scheduleMonthlyReminder() async {
    await _plugin.cancel(id: 999);

    await _plugin.periodicallyShow(
      id: 999,
      title: 'تذكير بالفحص الدوري',
      body: 'حان وقت إجراء الفحص الذاتي الشهري',
      repeatInterval: RepeatInterval.weekly,
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          'sakeena_reminder',
          'تذكيرات الفحص',
          channelDescription: 'تذكيرات الفحص الشهري',
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.inexact, // ← التغيير هنا
    );
  }

  static Future<void> cancelReminder() async {
    await _plugin.cancel(id: 999);
  }
}
