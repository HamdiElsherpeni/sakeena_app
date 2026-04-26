import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakeena_app/features/chat/presentation/widgets/custom_input_form.dart';
import 'package:sakeena_app/features/chat/presentation/widgets/recording_widget.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:sakeena_app/features/chat/presentation/view_model/send_message_cubit.dart';

class FormFieldBlocBuilder extends StatefulWidget {
  const FormFieldBlocBuilder({super.key});

  @override
  State<FormFieldBlocBuilder> createState() => _FormFieldBlocBuilderState();
}

class _FormFieldBlocBuilderState extends State<FormFieldBlocBuilder> {
  final stt.SpeechToText speechToText = stt.SpeechToText();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SendMessageCubit, SendMessageState>(
      builder: (context, state) {
        if (state is SendMessageRecording) return const RecordingWidget();
        return Padding(
          padding: const EdgeInsets.only(top: 8),
          child: CustomInputForm(
            formKey: formKey,
            textController: textController,
            speechToText: speechToText,
          ),
        );
      },
    );
  }
}
