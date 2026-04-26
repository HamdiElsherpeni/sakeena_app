import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:sakeena_app/features/chat/data/models/send_message_request_model.dart';
import 'package:sakeena_app/features/chat/presentation/view_model/send_message_cubit.dart';

class CustomInputForm extends StatefulWidget {
  const CustomInputForm({
    super.key,
    required this.formKey,
    required this.textController,
    required this.speechToText,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController textController;
  final stt.SpeechToText speechToText;

  @override
  State<CustomInputForm> createState() => _CustomInputFormState();
}

class _CustomInputFormState extends State<CustomInputForm> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SendMessageCubit, SendMessageState>(
      builder: (context, state) {
        return Form(
          key: widget.formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: TextFormField(
              controller: widget.textController,
              enabled: state is! SendMessageLoading,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                hintText: 'Ask your question...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                suffixIcon: InkWell(
                  onTap: state is SendMessageLoading
                      ? null
                      : () async {
                          if (widget.textController.text.isNotEmpty) {
                            await _sendMessage(context);
                          }
                        },
                  onLongPress: state is SendMessageLoading
                      ? null
                      : () async {
                          if (widget.textController.text.isEmpty) {
                            await BlocProvider.of<SendMessageCubit>(
                              context,
                            ).recordText(
                              context,
                              textController: widget.textController,
                            );
                          }
                        },
                  child: Icon(
                    widget.textController.text.isNotEmpty
                        ? Icons.send
                        : Icons.mic,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _sendMessage(BuildContext context) async {
    if (widget.formKey.currentState!.validate()) {
      final text = widget.textController.text;
      widget.textController.clear();
      await BlocProvider.of<SendMessageCubit>(context).sendMessage(
        sendMessageRequestModel: SendMessageRequestModel(message: text),
      );
    }
  }
}
