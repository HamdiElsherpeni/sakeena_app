import 'package:dartz/dartz.dart';
import 'package:sakeena_app/core/errors/failer.dart';
import 'package:sakeena_app/core/network/api_services.dart';
import '../models/notification_model.dart';

abstract class NotificationRepo {
  Future<Either<Failer, List<NotificationModel>>> getNotifications();
  Future<Either<Failer, void>> markAsRead(int id);
  Future<Either<Failer, void>> markAllAsRead();
}

class NotificationRepoImpl implements NotificationRepo {
  const NotificationRepoImpl();

  @override
  Future<Either<Failer, List<NotificationModel>>> getNotifications() async {
    try {
      final response = await ApiService.get('/api/notifications');

      final rawList = response['data'] ?? response['notifications'] ?? response;

      if (rawList is! List) return const Right([]);

      final list = rawList
          .map((e) => NotificationModel.fromJson(e as Map<String, dynamic>))
          .toList();

      return Right(list);
    } on ServerFailer catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailer('حدث خطأ غير متوقع.'));
    }
  }

  @override
  Future<Either<Failer, void>> markAsRead(int id) async {
    try {
      await ApiService.put('/api/notifications/$id/mark-read');
      return const Right(null);
    } on ServerFailer catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailer('حدث خطأ أثناء تحديث الإشعار.'));
    }
  }

  @override
  Future<Either<Failer, void>> markAllAsRead() async {
    try {
      await ApiService.put('/api/notifications/mark-all-read');
      return const Right(null);
    } on ServerFailer catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailer('حدث خطأ أثناء تحديث الإشعارات.'));
    }
  }
}
