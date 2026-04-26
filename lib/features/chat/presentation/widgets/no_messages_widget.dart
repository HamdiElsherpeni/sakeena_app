import 'package:flutter/material.dart';
import 'package:sakeena_app/features/chat/presentation/widgets/welcome_text.dart';

class NoMessagesWidget extends StatelessWidget {
  const NoMessagesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Padding(
        padding: EdgeInsets.only(left: 15, top: 50),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              WelcomeText(),
              SizedBox(height: 10),
              Text(
                'How can I help you today?',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff444746),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
