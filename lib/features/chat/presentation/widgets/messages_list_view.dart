import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakeena_app/features/chat/presentation/view_model/send_message_cubit.dart';
import 'package:sakeena_app/features/chat/presentation/widgets/animation_loading.dart';
import 'package:sakeena_app/features/chat/presentation/widgets/message_item.dart';
import 'package:sakeena_app/features/chat/presentation/widgets/no_messages_widget.dart';

class MessagesListView extends StatefulWidget {
  const MessagesListView({super.key, required this.cubit, required this.state});

  final SendMessageCubit cubit;
  final SendMessageState state;

  @override
  State<MessagesListView> createState() => _MessagesListViewState();
}

class _MessagesListViewState extends State<MessagesListView> {
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    if (widget.cubit.messages.isEmpty) return const NoMessagesWidget();

    return BlocListener<SendMessageCubit, SendMessageState>(
      listener: (context, state) {
        if (state is SendMessageLoading ||
            state is SendMessageSuccess ||
            state is SendMessageFailure) {
          _scrollToEnd();
        }
      },
      child: Expanded(
        child: ListView.builder(
          controller: scrollController,
          itemCount: widget.state is SendMessageLoading
              ? widget.cubit.messages.length + 1
              : widget.cubit.messages.length,
          itemBuilder: (context, index) {
            if (widget.state is SendMessageLoading &&
                index >= widget.cubit.messages.length) {
              return const AnimationLoading();
            }
            return Padding(
              padding: const EdgeInsets.only(top: 10),
              child: MessageItem(message: widget.cubit.messages[index]),
            );
          },
        ),
      ),
    );
  }

  void _scrollToEnd() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }
}
