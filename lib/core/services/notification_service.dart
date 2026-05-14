import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  // ================= INIT =================
  static Future<void> init() async {
    const AndroidInitializationSettings androidInit =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings iosInit = DarwinInitializationSettings();

    const InitializationSettings settings = InitializationSettings(
      android: androidInit,
      iOS: iosInit,
    );

    await _plugin.initialize(settings);
  }

  // ================= SHOW NOTIFICATION =================
  static Future<void> showNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'sakeena_channel',
      'Sakeena Notifications',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails details = NotificationDetails(
      android: androidDetails,
      iOS: DarwinNotificationDetails(),
    );

    await _plugin.show(id, title, body, details);
  }

  // ================= CANCEL SINGLE =================
  static Future<void> cancel(int id) async {
    await _plugin.cancel(id);
  }

  // ================= CANCEL REMINDER =================
  static Future<void> cancelReminder() async {
    await _plugin.cancel(999);
  }

  // ================= MONTHLY REMINDER =================
  static Future<void> scheduleMonthlyReminder() async {
    await _plugin.zonedSchedule(
      999,
      'Sakeena 💗',
      'لا تنسي إجراء الفحص الدوري',
      _nextMonthDate(),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'sakeena_channel',
          'Sakeena Notifications',
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.dayOfMonthAndTime,
    );
  }

  // ================= NEXT MONTH DATE =================
  static tz.TZDateTime _nextMonthDate() {
    final now = tz.TZDateTime.now(tz.local);

    return tz.TZDateTime(
      tz.local,
      now.year,
      now.month + 1,
      now.day,
      9,
      0,
    );
  }
}
