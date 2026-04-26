import 'package:dartz/dartz.dart';
import 'package:sakeena_app/core/errors/failer.dart';
import 'package:sakeena_app/features/chat/domain/entities/message_entity.dart';
import 'package:sakeena_app/features/chat/data/models/send_message_request_model.dart';

abstract class ChatRepository {
  Future<Either<Failer, MessageEntity>> sendMessage(
    SendMessageRequestModel request,
  );
}
