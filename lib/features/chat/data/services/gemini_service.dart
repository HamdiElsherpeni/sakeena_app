import 'package:dio/dio.dart';
import 'package:sakeena_app/features/chat/domain/entities/message_entity.dart';
import 'package:sakeena_app/features/chat/data/models/message_model.dart';
import 'package:sakeena_app/features/chat/data/models/send_message_request_model.dart';

class GeminiService {
  static const String _baseUrl =
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent';
  static const String _apiKey = 'AIzaSyBDF_uBRlDUpOMir3HUGELOFlKDn6UwiDw';
  final Dio _dio = Dio();

  Future<MessageEntity> sendMessage(SendMessageRequestModel request) async {
    try {
      final response = await _dio.post(
        '$_baseUrl?key=$_apiKey',
        data: request.toJson(),
        options: Options(headers: {'Content-Type': 'application/json'}),
      );
      return MessageModel.fromJson(response.data);
    } on DioException catch (e) {
      print('❌ Status: ${e.response?.statusCode}');
      print('❌ Data: ${e.response?.data}');
      rethrow;
    }
  }
}
