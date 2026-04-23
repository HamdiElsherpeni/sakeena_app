class PredictionHistoryModel {
  final String id;
  final String prediction;
  final double confidence;
  final String imageUrl;
  final DateTime createdAt;

  PredictionHistoryModel({
    required this.id,
    required this.prediction,
    required this.confidence,
    required this.imageUrl,
    required this.createdAt,
  });

  bool get isMalignant => prediction.toLowerCase().contains('malignant');

  factory PredictionHistoryModel.fromJson(Map<String, dynamic> json) {
    return PredictionHistoryModel(
      id: json['id'] ?? '',
      prediction: json['prediction'] ?? json['Prediction'] ?? '',
      confidence: (json['confidence'] ?? json['Confidence'] ?? 0).toDouble(),
      imageUrl: json['imageUrl'] ?? json['ImageUrl'] ?? '',
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
    );
  }
}

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
