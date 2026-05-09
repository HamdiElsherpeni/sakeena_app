import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakeena_app/features/notifications/data/models/notification_model.dart';
import 'package:sakeena_app/features/notifications/data/repos/notification_repo.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit(this._repo) : super(NotificationInitial());

  final NotificationRepo _repo;

  List<NotificationModel> _all = [];

  // ─── Load ──────────────────────────────────────────────────────────────────

  Future<void> loadNotifications() async {
    emit(NotificationLoading());

    final result = await _repo.getNotifications();

    result.fold((failure) => emit(NotificationFailure(failure.errorMessage)), (
      list,
    ) {
      _all = List.from(list);
      emit(NotificationSuccess(notifications: _all));
    });
  }

  // ─── Mark as read ──────────────────────────────────────────────────────────

  Future<void> markAsRead(int id) async {
    // optimistic update
    _all = _all.map((n) => n.id == id ? n.copyWith(isRead: true) : n).toList();
    emit(NotificationSuccess(notifications: _all));

    await _repo.markAsRead(id);
  }

  // ─── Mark all as read ──────────────────────────────────────────────────────

  Future<void> markAllAsRead() async {
    // optimistic update
    _all = _all.map((n) => n.copyWith(isRead: true)).toList();
    emit(NotificationSuccess(notifications: _all));

    await _repo.markAllAsRead();
  }

  // ─── Helpers ───────────────────────────────────────────────────────────────

  int get unreadCount => _all.where((n) => !n.isRead).length;
}
