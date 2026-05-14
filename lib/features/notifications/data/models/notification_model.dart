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
      body:
          json['body'] as String? ??
          json['message'] as String? ??
          json['content'] as String? ??
          '',
      createdAt:
          json['createdAt'] as String? ??
          json['date'] as String? ??
          json['created_at'] as String? ??
          '',
      isRead: json['isRead'] as bool? ?? json['is_read'] as bool? ?? false,
      type: NotificationType.fromString(json['type'] as String? ?? ''),
    );
  }

  NotificationModel copyWith({bool? isRead}) => NotificationModel(
    id: id,
    title: title,
    body: body,
    createdAt: createdAt,
    isRead: isRead ?? this.isRead,
    type: type,
  );

  String get formattedTime {
    if (createdAt.isEmpty) return '';
    try {
      // الـ API بيبعت UTC — نحوله للـ local time الصح
      final raw = createdAt.endsWith('Z') ? createdAt : '${createdAt}Z';
      final date = DateTime.parse(raw).toLocal();
      final now = DateTime.now();
      final diff = now.difference(date);

      if (diff.isNegative || diff.inSeconds < 60) return 'الآن';
      if (diff.inMinutes < 60) {
        final m = diff.inMinutes;
        return 'منذ $m ${m == 1 ? 'دقيقة' : (m < 11 ? 'دقائق' : 'دقيقة')}';
      }
      if (diff.inHours < 24) {
        final h = diff.inHours;
        return 'منذ $h ${h == 1 ? 'ساعة' : (h < 11 ? 'ساعات' : 'ساعة')}';
      }
      if (diff.inDays == 1) return 'أمس';
      if (diff.inDays < 7) {
        final d = diff.inDays;
        return 'منذ $d ${d < 11 ? 'أيام' : 'يوم'}';
      }
      // أكثر من أسبوع → نعرض التاريخ
      return '${date.day}/${date.month}/${date.year}';
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
      case 'predictionresult':
      case 'prediction_result':
        return NotificationType.scanResult;
      case 'reminder':
        return NotificationType.reminder;
      default:
        return NotificationType.general;
    }
  }
}
