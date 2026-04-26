import 'package:flutter/material.dart';
import 'package:sakeena_app/features/chat/domain/entities/message_entity.dart';

class MessageItem extends StatelessWidget {
  const MessageItem({super.key, required this.message});

  final MessageEntity message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: message.isUserMessage ? 40 : 10,
        right: message.isUserMessage ? 10 : 40,
      ),
      child: Align(
        alignment: message.isUserMessage
            ? Alignment.centerRight
            : Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: ShapeDecoration(
            color: message.isUserMessage ? Colors.grey[300] : Colors.grey[800],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(17),
            ),
          ),
          child: Text(
            message.message,
            softWrap: true,
            style: TextStyle(
              color: message.isUserMessage ? Colors.black : Colors.white,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
