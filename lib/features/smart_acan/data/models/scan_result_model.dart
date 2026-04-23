class ScanResultModel {
  final double confidence;
  final String diagnosis;
  final String message;
  final String status;
  final bool success;

  ScanResultModel({
    required this.confidence,
    required this.diagnosis,
    required this.message,
    required this.status,
    required this.success,
  });

  bool get isMalignant => status.toLowerCase() == 'malignant';
  bool get isBenign => status.toLowerCase() == 'benign';
  bool get isNormal => status.toLowerCase() == 'normal'; // ✅ جديد

  factory ScanResultModel.fromJson(Map<String, dynamic> json) {
    final prediction = json['prediction'] as Map<String, dynamic>;
    return ScanResultModel(
      confidence: (prediction['confidence'] ?? 0).toDouble(),
      diagnosis: prediction['diagnosis'] ?? '',
      message: prediction['message'] ?? '',
      status: prediction['status'] ?? '',
      success: json['success'] ?? false,
    );
  }
}
