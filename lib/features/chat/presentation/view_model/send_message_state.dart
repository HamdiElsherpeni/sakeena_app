part of 'send_message_cubit.dart';

abstract class SendMessageState {}

class SendMessageInitial extends SendMessageState {}

class SendMessageLoading extends SendMessageState {}

class SendMessageSuccess extends SendMessageState {}

class SendMessageFailure extends SendMessageState {}

class SendMessageRecording extends SendMessageState {}
