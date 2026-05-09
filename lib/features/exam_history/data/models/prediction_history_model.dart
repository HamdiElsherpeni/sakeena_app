class PredictionHistoryModel {
  final int id;
  final String predictionDate; // ISO string من السيرفر
  final String status; // "Benign" | "Malignant" | "Unknown"
  final String imageUrl;
  final double confidence;

  const PredictionHistoryModel({
    required this.id,
    required this.predictionDate,
    required this.status,
    required this.imageUrl,
    this.confidence = 0.0,
  });

  factory PredictionHistoryModel.fromJson(Map<String, dynamic> json) {
    return PredictionHistoryModel(
      // السيرفر ممكن يبعت "id" أو مفيش id خالص → نحط 0 fallback
      id: json['id'] as int? ?? 0,

      // السيرفر بيبعت "createdAt" مش "predictionDate"
      predictionDate:
          json['predictionDate'] as String? ??
          json['createdAt'] as String? ??
          '',

      // السيرفر بيبعت "diagnosis" مش "status"
      status:
          json['status'] as String? ??
          json['diagnosis'] as String? ??
          'Unknown',

      imageUrl: json['imageUrl'] as String? ?? '',

      confidence: (json['confidence'] as num?)?.toDouble() ?? 0.0,
    );
  }

  /// تحويل الـ status من السيرفر لـ PredictionStatus
  /// Benign    → safe
  /// Malignant → danger
  /// Unknown   → moderate
  PredictionStatus get predictionStatus {
    switch (status.toLowerCase()) {
      case 'benign':
        return PredictionStatus.benign;
      case 'malignant':
        return PredictionStatus.malignant;
      default:
        return PredictionStatus.unknown;
    }
  }

  String get formattedDate {
    try {
      final date = DateTime.parse(predictionDate).toLocal();
      const months = [
        '',
        'يناير',
        'فبراير',
        'مارس',
        'أبريل',
        'مايو',
        'يونيو',
        'يوليو',
        'أغسطس',
        'سبتمبر',
        'أكتوبر',
        'نوفمبر',
        'ديسمبر',
      ];
      return '${date.day} ${months[date.month]} ${date.year}';
    } catch (_) {
      return predictionDate;
    }
  }
}

enum PredictionStatus { benign, malignant, unknown }

extension PredictionStatusX on PredictionStatus {
  String get riskLabel {
    switch (this) {
      case PredictionStatus.benign:
        return 'خطر منخفض';
      case PredictionStatus.malignant:
        return 'خطر عالٍ';
      case PredictionStatus.unknown:
        return 'خطر متوسط';
    }
  }

  String get badgeLabel {
    switch (this) {
      case PredictionStatus.benign:
        return 'آمن';
      case PredictionStatus.malignant:
        return 'خطير';
      case PredictionStatus.unknown:
        return 'متابعة';
    }
  }
}
