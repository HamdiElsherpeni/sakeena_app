import 'package:dio/dio.dart';

abstract class Failer {
  final String errorMessage;

  Failer(this.errorMessage);
}

class ServerFailer extends Failer {
  ServerFailer(super.errorMessage);

  factory ServerFailer.fromDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailer('انتهت مهلة الاتصال. يرجى المحاولة مرة أخرى.');
      case DioExceptionType.sendTimeout:
        return ServerFailer('انتهت مهلة إرسال الطلب. يرجى المحاولة مرة أخرى.');
      case DioExceptionType.receiveTimeout:
        return ServerFailer('انتهت مهلة استقبال الرد. يرجى المحاولة مرة أخرى.');
      case DioExceptionType.badCertificate:
        return ServerFailer('شهادة الأمان غير صالحة.');
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode ?? 0;
        final responseData = e.response?.data;
        return ServerFailer.fromResponse(statusCode, responseData);
      case DioExceptionType.cancel:
        return ServerFailer('تم إلغاء الطلب.');
      case DioExceptionType.connectionError:
        return ServerFailer('خطأ في الاتصال. يرجى التحقق من اتصالك بالإنترنت.');
      case DioExceptionType.unknown:
        return ServerFailer('حدث خطأ غير متوقع. يرجى المحاولة مرة أخرى.');
      default:
        return ServerFailer('حدث خطأ غير متوقع.');
    }
  }

  factory ServerFailer.fromResponse(int statusCode, dynamic response) {
    switch (statusCode) {
      case 400:
        return ServerFailer(
          'البيانات المدخلة غير صحيحة. يرجى مراجعة المعلومات والمحاولة مرة أخرى.',
        );
      case 401:
        return ServerFailer(
          'غير مصرح لك. يرجى تسجيل الدخول مرة أخرى للمتابعة.',
        );
      case 403:
        return ServerFailer(
          'الوصول مرفوض. ليس لديك صلاحية للقيام بهذا الإجراء.',
        );
      case 404:
        return ServerFailer('المورد المطلوب غير موجود.');
      case 409:
        return ServerFailer(
          'هذا الإيميل مسجل بالفعل. يرجى تسجيل الدخول أو استخدام إيميل آخر.',
        );
      case 422:
        return ServerFailer('البيانات المدخلة غير مكتملة أو غير صحيحة.');
      case 429:
        return ServerFailer(
          'لقد تجاوزت الحد المسموح به من المحاولات. يرجى الانتظار قليلاً.',
        );
      case 500:
        return ServerFailer(
          'حدث خطأ في الخادم. يرجى المحاولة مرة أخرى لاحقاً.',
        );
      case 502:
        return ServerFailer(
          'البوابة غير متاحة حالياً. يرجى المحاولة مرة أخرى.',
        );
      case 503:
        return ServerFailer(
          'الخدمة غير متاحة مؤقتاً. يرجى المحاولة مرة أخرى لاحقاً.',
        );
      case 504:
        return ServerFailer(
          'انتهت مهلة الاستجابة من الخادم. يرجى المحاولة مرة أخرى.',
        );
      default:
        String? serverMessage;
        if (response is Map) {
          serverMessage =
              response['message']?.toString() ??
              response['Message']?.toString() ??
              response['error']?.toString() ??
              response['Error']?.toString();
        } else if (response is String && response.isNotEmpty) {
          serverMessage = response;
        }
        return ServerFailer(
          serverMessage ?? 'حدث خطأ غير متوقع. يرجى المحاولة مرة أخرى.',
        );
    }
  }
}
