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
  bool get isNormal => status.toLowerCase() == 'normal';

  factory ScanResultModel.fromJson(Map<String, dynamic> json) {
    // ✅ السيرفر ممكن يبعت الداتا جوا 'prediction' أو مباشرة
    final prediction = json['prediction'] is Map<String, dynamic>
        ? json['prediction'] as Map<String, dynamic>
        : json;

    return ScanResultModel(
      confidence: (prediction['confidence'] ?? prediction['Confidence'] ?? 0).toDouble(),
      diagnosis: prediction['diagnosis'] ?? prediction['Diagnosis'] ?? '',
      message: prediction['message'] ?? prediction['Message'] ?? '',
      status: prediction['status'] ?? prediction['Status'] ?? '',
      success: json['success'] ?? json['Success'] ?? true,
    );
  }
}