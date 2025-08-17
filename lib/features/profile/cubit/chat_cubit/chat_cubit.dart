import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/core/services/connection_service.dart';
import 'package:e_fashion_flutter/core/services/signalr_service.dart';
import 'package:e_fashion_flutter/features/profile/cubit/chat_cubit/chat_state.dart';
import 'package:e_fashion_flutter/features/profile/data/chat/send_message_model.dart';
import 'package:e_fashion_flutter/features/profile/repos/chat_repo/chat_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatRepo chatRepo;
  final SignalrService signalrService;

  ChatCubit({required this.chatRepo, required this.signalrService})
    : super(const ChatState()) {
    ConnectionsService.initConnection();
  }

  Future<void> getChatHistory({required String receiverId}) async {
    if (chatRepo.getCachedMessages().isNotEmpty) {
      emit(
        state.copyWith(
          getChatHistoryState: RequestStatus.success,
          messageList: chatRepo.getCachedMessages(),
        ),
      );
      return;
    }
    final result = await chatRepo.getChatHistory(receiverId: receiverId);
    result.fold(
      (failure) => emit(
        state.copyWith(
          getChatHistoryErrorMessage: failure.errorMessage,
          getChatHistoryState: RequestStatus.error,
        ),
      ),
      (messageList) {
        emit(
          state.copyWith(
            getChatHistoryState: RequestStatus.success,
            messageList: messageList,
          ),
        );
      },
    );
  }

  Future<void> listenToMessages() async {
    await signalrService.listenToMessages((message) {
      chatRepo.addMessage(message);
      emit(state.copyWith(messageList: [...state.messageList, message]));
    });
  }

  Future<void> sendChatMessage({
    required SendMessageModel sendMessageModel,
  }) async {
    await signalrService.sendMessage(sendMessageModel: sendMessageModel);
  }
}
