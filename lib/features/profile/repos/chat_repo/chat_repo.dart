import 'package:dartz/dartz.dart';
import 'package:e_fashion_flutter/core/error/failures.dart';
import 'package:e_fashion_flutter/features/profile/data/chat/message_model.dart';
import 'package:e_fashion_flutter/features/profile/data/chat/send_message_model.dart';

abstract class ChatRepo {
  Future<Either<Failure, List<MessageModel>>> getChatHistory({
    required String receiverId,
  });
  Future<Either<Failure, void>> sendMessage({
    required SendMessageModel sendMessageModel,
  });
}
