import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/core/services/connection_service.dart';
import 'package:e_fashion_flutter/core/services/signalr_service.dart';
import 'package:e_fashion_flutter/features/profile/cubit/chat_cubit/chat_state.dart';
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
    required String content,
    required String senderId,
    required String receiverId,
    required int chatId,
  }) async {
    await signalrService.sendMessage(
      message: content,
      senderId: senderId,
      receiverId: receiverId,
      chatId: chatId,
    );
  }
}
