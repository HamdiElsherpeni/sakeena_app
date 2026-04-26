import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:sakeena_app/core/errors/failer.dart';
import 'package:sakeena_app/features/chat/domain/entities/message_entity.dart';
import 'package:sakeena_app/features/chat/data/models/send_message_request_model.dart';
import 'package:sakeena_app/features/chat/data/datasources/base_chat_datasource.dart';
import 'package:sakeena_app/features/chat/domain/repositories/chat_repository.dart';

class ChatRepoImpl extends ChatRepository {
  final BaseChatDataSource dataSource;
  ChatRepoImpl(this.dataSource);

  @override
  Future<Either<Failer, MessageEntity>> sendMessage(
    SendMessageRequestModel request,
  ) async {
    try {
      final result = await dataSource.sendMessage(request);
      return Right(result);
    } on DioException catch (e) {
      return Left(ServerFailer.fromDioError(e));
    } catch (e) {
      return Left(ServerFailer('حدث خطأ غير متوقع'));
    }
  }
}
