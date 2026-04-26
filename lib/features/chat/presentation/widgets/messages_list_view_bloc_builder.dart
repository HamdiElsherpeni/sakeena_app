import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakeena_app/features/chat/presentation/view_model/send_message_cubit.dart';
import 'package:sakeena_app/features/chat/presentation/widgets/messages_list_view.dart';

class MessagesListViewBlocBuilder extends StatelessWidget {
  const MessagesListViewBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<SendMessageCubit>(context);
    return BlocBuilder<SendMessageCubit, SendMessageState>(
      builder: (context, state) => MessagesListView(cubit: cubit, state: state),
    );
  }
}
