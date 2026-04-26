import 'package:sakeena_app/features/chat/domain/entities/message_entity.dart';
import 'package:sakeena_app/features/chat/data/models/send_message_request_model.dart';
import 'package:sakeena_app/features/chat/data/services/gemini_service.dart';
import 'base_chat_datasource.dart';

class ChatRemoteDataSource extends BaseChatDataSource {
  final GeminiService geminiService;
  ChatRemoteDataSource(this.geminiService);

  @override
  Future<MessageEntity> sendMessage(SendMessageRequestModel request) =>
      geminiService.sendMessage(request);
}
