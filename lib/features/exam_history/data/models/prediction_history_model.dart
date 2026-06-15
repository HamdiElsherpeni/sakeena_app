class PredictionHistoryModel {
  final int id;
  final String predictionDate;
  final String status;
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
      id: json['id'] as int? ?? 0,
      predictionDate:
          json['predictionDate'] as String? ??
          json['createdAt'] as String? ??
          '',
      status:
          json['status'] as String? ??
          json['diagnosis'] as String? ??
          'Unknown',
      imageUrl: json['imageUrl'] as String? ?? '',
      confidence: (json['confidence'] as num?)?.toDouble() ?? 0.0,
    );
  }

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
        'يناير', 'فبراير', 'مارس', 'أبريل', 'مايو', 'يونيو',
        'يوليو', 'أغسطس', 'سبتمبر', 'أكتوبر', 'نوفمبر', 'ديسمبر',
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

// ✅ انتقلت من smart_acan
class PredictionStatisticsModel {
  final int total;
  final int benign;
  final int malignant;

  PredictionStatisticsModel({
    required this.total,
    required this.benign,
    required this.malignant,
  });

  factory PredictionStatisticsModel.fromJson(Map<String, dynamic> json) {
    return PredictionStatisticsModel(
      total: json['total'] ?? json['Total'] ?? 0,
      benign: json['benign'] ?? json['Benign'] ?? 0,
      malignant: json['malignant'] ?? json['Malignant'] ?? 0,
    );
  }
}