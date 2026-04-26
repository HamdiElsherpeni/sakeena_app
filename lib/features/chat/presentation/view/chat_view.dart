import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:sakeena_app/core/resources/app_colors.dart';
import 'package:sakeena_app/features/chat/domain/usecases/send_message_usecase.dart';
import 'package:sakeena_app/features/chat/data/services/stt_service.dart';
import 'package:sakeena_app/features/chat/presentation/view_model/send_message_cubit.dart';
import 'package:sakeena_app/features/chat/presentation/widgets/chat_view_body.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SendMessageCubit(
        GetIt.instance<SendMessageUseCase>(),
        GetIt.instance<SpeechToTextService>(),
      ),
      child: const Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: ChatViewBody(),
        ),
        backgroundColor: AppColors.kprimaryColor,
      ),
    );
  }
}
