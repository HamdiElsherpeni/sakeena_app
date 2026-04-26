import 'package:flutter/material.dart';
import 'package:sakeena_app/features/chat/presentation/widgets/custom_app_bar.dart';
import 'package:sakeena_app/features/chat/presentation/widgets/form_field_bloc_builder.dart';
import 'package:sakeena_app/features/chat/presentation/widgets/messages_list_view_bloc_builder.dart';

class ChatViewBody extends StatelessWidget {
  const ChatViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Column(
        children: [
          SizedBox(height: 20),
          ChatAppBar(),
          MessagesListViewBlocBuilder(),
          FormFieldBlocBuilder(),
          SizedBox(height: 15),
        ],
      ),
    );
  }
}
