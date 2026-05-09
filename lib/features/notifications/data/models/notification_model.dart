class NotificationModel {
  final int id;
  final String title;
  final String body;
  final String createdAt;
  final bool isRead;
  final NotificationType type;

  const NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.createdAt,
    required this.isRead,
    required this.type,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? '',
      body: json['body'] as String? ?? json['message'] as String? ?? '',
      createdAt: json['createdAt'] as String? ?? json['date'] as String? ?? '',
      isRead: json['isRead'] as bool? ?? false,
      type: NotificationType.fromString(json['type'] as String? ?? ''),
    );
  }

  NotificationModel copyWith({bool? isRead}) {
    return NotificationModel(
      id: id,
      title: title,
      body: body,
      createdAt: createdAt,
      isRead: isRead ?? this.isRead,
      type: type,
    );
  }

  String get formattedTime {
    try {
      final date = DateTime.parse(createdAt).toLocal();
      final now = DateTime.now();
      final diff = now.difference(date);

      if (diff.inMinutes < 60) return 'منذ ${diff.inMinutes} دقيقة';
      if (diff.inHours < 24) return 'منذ ${diff.inHours} ساعة';
      if (diff.inDays == 1) return 'أمس';
      return 'منذ ${diff.inDays} أيام';
    } catch (_) {
      return createdAt;
    }
  }
}

enum NotificationType {
  scanResult,
  reminder,
  general;

  static NotificationType fromString(String value) {
    switch (value.toLowerCase()) {
      case 'scanresult':
      case 'scan_result':
      case 'result':
        return NotificationType.scanResult;
      case 'reminder':
        return NotificationType.reminder;
      default:
        return NotificationType.general;
    }
  }
}
