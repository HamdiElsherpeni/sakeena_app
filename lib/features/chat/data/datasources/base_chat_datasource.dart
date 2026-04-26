import 'package:sakeena_app/features/chat/domain/entities/message_entity.dart';
import 'package:sakeena_app/features/chat/data/models/send_message_request_model.dart';

abstract class BaseChatDataSource {
  Future<MessageEntity> sendMessage(SendMessageRequestModel request);
}
