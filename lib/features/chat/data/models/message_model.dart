import 'package:sakeena_app/features/chat/domain/entities/message_entity.dart';

class MessageModel extends MessageEntity {
  MessageModel({required super.message, required super.isUserMessage});

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    final text = json['candidates'][0]['content']['parts'][0]['text'] as String;
    return MessageModel(message: text, isUserMessage: false);
  }
}
