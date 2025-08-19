import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_fashion_flutter/core/error/error_model.dart';
import 'package:e_fashion_flutter/core/error/failures.dart';
import 'package:e_fashion_flutter/core/error/server_exception.dart';
import 'package:e_fashion_flutter/core/network/api_constants.dart';
import 'package:e_fashion_flutter/core/network/dio_helper.dart';
import 'package:e_fashion_flutter/core/utils/app_constants.dart';
import 'package:e_fashion_flutter/features/profile/data/chat/message_model.dart';
import 'package:e_fashion_flutter/features/profile/data/chat/send_message_model.dart';
import 'package:e_fashion_flutter/features/profile/repos/chat_repo/chat_repo.dart';

class ChatRepoImpl implements ChatRepo {
  final DioHelper dioHelper;

  ChatRepoImpl({required this.dioHelper});

  List<MessageModel> _messages = [];

  @override
  Future<Either<Failure, List<MessageModel>>> getChatHistory({
    required String receiverId,
  }) async {
    try {
      final response = await dioHelper.get(
        url: ApiConstants.getChatHistoryEndPoint(receiverId: receiverId),
        headers: {"Authorization": "Bearer ${AppConstants.token}"},
      );
      if (response.statusCode == 200) {
        _messages = List<MessageModel>.from(
          (response.data as List? ?? []).map(
            (message) => MessageModel.fromJson(message),
          ),
        );
        return Right(_messages);
      } else {
        throw ServerException(errorModel: ErrorModel.fromJson(response.data));
      }
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  List<MessageModel> getCachedMessages() => List.unmodifiable(_messages);

  @override
  void addMessage(MessageModel message) {
    _messages.add(message);
  }

  @override
  Future<Either<Failure, void>> sendMessage({
    required SendMessageModel sendMessageModel,
  }) async {
    try {
      final response = await dioHelper.post(
        url: ApiConstants.sendMessageEndpoint,
        data: sendMessageModel.toJson(),
        headers: {"Authorization": "Bearer ${AppConstants.token}"},
      );
      if (response.statusCode == 200) {
        return const Right(null);
      } else {
        throw ServerException(errorModel: ErrorModel.fromJson(response.data));
      }
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
