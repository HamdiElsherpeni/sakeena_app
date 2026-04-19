import 'package:dio/dio.dart';

abstract class Failer {
  final String errorMessage;

  Failer(this.errorMessage);
}

class ServerFailer extends Failer {
  ServerFailer(super.errorMessage);

  /// يحوّل DioException إلى رسالة مفهومة
  factory ServerFailer.fromDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailer('Connection timed out. Please try again.');
      case DioExceptionType.sendTimeout:
        return ServerFailer('Request send timed out. Please try again.');
      case DioExceptionType.receiveTimeout:
        return ServerFailer('Response timed out. Please try again.');
      case DioExceptionType.badCertificate:
        return ServerFailer('Bad SSL certificate.');
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode ?? 0;
        final responseData = e.response?.data;
        return ServerFailer.fromResponse(statusCode, responseData);
      case DioExceptionType.cancel:
        return ServerFailer('Request was cancelled.');
      case DioExceptionType.connectionError:
        return ServerFailer('Connection error. Please check your internet.');
      case DioExceptionType.unknown:
        return ServerFailer('Oops, there was an unexpected error.');
      default:
        return ServerFailer('An unexpected error occurred.');
    }
  }

  /// يحوّل statusCode إلى رسالة مناسبة
  factory ServerFailer.fromResponse(int statusCode, dynamic response) {
  switch (statusCode) {
    case 400:
      return ServerFailer(
          'Oops! Your request seems incorrect. Please check your input and try again.');
    case 401:
      return ServerFailer(
          'You are not authorized. Please log in again to continue.');
    case 403:
      return ServerFailer(
          'Access denied. You do not have permission to perform this action.');
    case 404:
      return ServerFailer(
          'The resource you are looking for could not be found.');
    case 500:
      return ServerFailer(
          'Something went wrong on the server. Please try again later.');
    case 502:
      return ServerFailer(
          'Bad gateway. The server is currently unreachable. Please try again.');
    case 503:
      return ServerFailer(
          'Service unavailable. The server is temporarily down. Please try again later.');
    case 504:
      return ServerFailer(
          'Gateway timeout. The server is taking too long to respond.');
    default:
      // لو response فيه رسالة واضحة من السيرفر نعرضها، وإلا نعرض رسالة عامة
      final message = response is Map && response['message'] != null
          ? response['message'].toString()
          : 'Unexpected error occurred (status code: $statusCode). Please try again.';
      return ServerFailer(message);
  }
}
}