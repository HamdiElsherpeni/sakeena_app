import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  NotificationService._();

  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  // ───────────────── INIT ─────────────────

  static Future<void> init() async {
    tz_data.initializeTimeZones();

    const android = AndroidInitializationSettings('@mipmap/ic_launcher');

    const ios = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const settings = InitializationSettings(android: android, iOS: ios);

    await _plugin.initialize(
      settings: settings,
      onDidReceiveNotificationResponse: (NotificationResponse details) {},
    );

    final androidImpl = _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();

    if (androidImpl != null) {
      await androidImpl.requestNotificationsPermission();
    }
  }

  // ───────────────── إشعار فوري ─────────────────

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
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
    );
  }

  // ───────────────── تذكير شهري ─────────────────

  static Future<void> scheduleMonthlyReminder() async {
    await _plugin.cancel(id: 999);

    final now = DateTime.now();

    final nextMonth = DateTime(now.year, now.month + 1, 1, 9, 0);

    final scheduled = tz.TZDateTime.from(nextMonth, tz.local);

    await _plugin.zonedSchedule(
      id: 999,
      title: 'تذكير بالفحص الدوري',
      body: 'حان وقت إجراء الفحص الذاتي الشهري',
      scheduledDate: scheduled,
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
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.dayOfMonthAndTime,
    );
  }

  // ───────────────── إلغاء التذكير ─────────────────

  static Future<void> cancelReminder() async {
    await _plugin.cancel(id: 999);
  }
}
