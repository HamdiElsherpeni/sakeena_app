import 'package:dartz/dartz.dart';
import 'package:sakeena_app/core/errors/failer.dart';
import 'package:sakeena_app/features/chat/domain/entities/message_entity.dart';
import 'package:sakeena_app/features/chat/data/models/send_message_request_model.dart';
import 'package:sakeena_app/features/chat/domain/repositories/chat_repository.dart';

class SendMessageUseCase {
  final ChatRepository repository;
  SendMessageUseCase(this.repository);

  Future<Either<Failer, MessageEntity>> execute(
    SendMessageRequestModel request,
  ) => repository.sendMessage(request);
}
