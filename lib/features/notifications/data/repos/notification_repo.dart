import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:sakeena_app/core/errors/failer.dart';
import 'package:sakeena_app/core/network/dio_factory.dart';
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
      final response = await DioFactory.dio.get('/api/notifications');
      final data = response.data;

      // ── استخرج الـ list بغض النظر عن شكل الـ response ──────────────────
      List<dynamic> rawList = [];

      if (data is List) {
        rawList = data;
      } else if (data is Map) {
        rawList = data['data'] ?? data['notifications'] ?? data['items'] ?? [];
      }

      final list = rawList
          .whereType<Map<String, dynamic>>()
          .map(NotificationModel.fromJson)
          .toList();

      return Right(list);
    } on DioException catch (e) {
      // ── 404 = مفيش إشعارات — مش error ───────────────────────────────────
      if (e.response?.statusCode == 404) return const Right([]);
      return Left(ServerFailer.fromDioError(e));
    } catch (e) {
      return Left(ServerFailer('حدث خطأ غير متوقع.'));
    }
  }

  @override
  Future<Either<Failer, void>> markAsRead(int id) async {
    try {
      await DioFactory.dio.put('/api/notifications/$id/mark-read');
      return const Right(null);
    } on DioException catch (e) {
      return Left(ServerFailer.fromDioError(e));
    } catch (e) {
      return Left(ServerFailer('حدث خطأ أثناء تحديث الإشعار.'));
    }
  }

  @override
  Future<Either<Failer, void>> markAllAsRead() async {
    try {
      await DioFactory.dio.put('/api/notifications/mark-all-read');
      return const Right(null);
    } on DioException catch (e) {
      return Left(ServerFailer.fromDioError(e));
    } catch (e) {
      return Left(ServerFailer('حدث خطأ أثناء تحديث الإشعارات.'));
    }
  }
}
