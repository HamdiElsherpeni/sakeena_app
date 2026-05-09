part of 'notification_cubit.dart';

abstract class NotificationState {}

class NotificationInitial extends NotificationState {}

class NotificationLoading extends NotificationState {}

class NotificationSuccess extends NotificationState {
  final List<NotificationModel> notifications;
  NotificationSuccess({required this.notifications});
}

class NotificationFailure extends NotificationState {
  final String message;
  NotificationFailure(this.message);
}
