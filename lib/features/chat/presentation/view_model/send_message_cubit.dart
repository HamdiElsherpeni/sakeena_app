import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakeena_app/features/chat/domain/entities/message_entity.dart';
import 'package:sakeena_app/features/chat/data/models/send_message_request_model.dart';
import 'package:sakeena_app/features/chat/data/services/stt_service.dart';
import 'package:sakeena_app/features/chat/domain/usecases/send_message_usecase.dart';

part 'send_message_state.dart';

class SendMessageCubit extends Cubit<SendMessageState> {
  final SendMessageUseCase sendMessageUseCase;
  final SpeechToTextService sttService;

  SendMessageCubit(this.sendMessageUseCase, this.sttService)
    : super(SendMessageInitial());

  List<MessageEntity> messages = [];
  bool isListening = false;

  Future<void> sendMessage({
    required SendMessageRequestModel sendMessageRequestModel,
  }) async {
    messages.add(
      MessageEntity(
        message: sendMessageRequestModel.message,
        isUserMessage: true,
      ),
    );
    emit(SendMessageLoading());

    final result = await sendMessageUseCase.execute(sendMessageRequestModel);
    result.fold(
      (failure) {
        messages.add(
          MessageEntity(message: failure.errorMessage, isUserMessage: false),
        );
        emit(SendMessageFailure());
      },
      (success) {
        messages.add(
          MessageEntity(message: success.message, isUserMessage: false),
        );
        emit(SendMessageSuccess());
      },
    );
  }

  Future<void> recordText(
    BuildContext context, {
    required TextEditingController textController,
  }) async {
    emit(SendMessageRecording());
    await sttService.listen(
      onResult: (result) {
        isListening = true;
        if (result.finalResult) {
          textController.text = result.recognizedWords;
          isListening = false;
          emit(SendMessageInitial());
        }
      },
    );
    await Future.delayed(const Duration(seconds: 4), () {
      if (!isListening) emit(SendMessageInitial());
    });
  }
}
