import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/core/services/connection_service.dart';
import 'package:e_fashion_flutter/core/services/signalr_service.dart';
import 'package:e_fashion_flutter/core/utils/app_constants.dart';
import 'package:e_fashion_flutter/features/profile/cubit/chat_cubit/chat_state.dart';
import 'package:e_fashion_flutter/features/profile/data/chat/send_message_model.dart';
import 'package:e_fashion_flutter/features/profile/repos/chat_repo/chat_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatRepo chatRepo;
  final SignalrService signalrService;

  ChatCubit({required this.chatRepo, required this.signalrService})
    : super(const ChatState()) {
    ConnectionsService.checkConnection();
    _listenToMessages();
    _listenToSentMessages();
  }

  Future<void> getChatHistory({
    required String receiverId,
  }) async {
    if (state.messages.isNotEmpty ) return;
    emit(state.copyWith(getChatHistoryState: RequestStatus.loading));
    final result = await chatRepo.getChatHistory(receiverId: receiverId,);
    result.fold(
      (failure) => emit(
        state.copyWith(
          getChatHistoryErrorMessage: failure.errorMessage,
          getChatHistoryState: RequestStatus.error,
        ),
      ),
      (messages) {
        emit(
          state.copyWith(
            getChatHistoryState: RequestStatus.success,
            messages: messages,
          ),
        );
      },
    );
  }

  void _listenToMessages() {
    signalrService.listenToMessages((message) {
      if (message.senderId != AppConstants.userId) {
        emit(state.copyWith(messages: [...state.messages, message]));
      }
    });
  }

  void _listenToSentMessages() {
    signalrService.listenToSentMessages((message) {
      if (message.senderId == AppConstants.userId) {
        emit(state.copyWith(messages: [...state.messages, message]));
      }
    });
  }

  Future<void> sendChatMessage({
    required SendMessageModel sendMessageModel,
  }) async {
    await signalrService.sendMessage(sendMessageModel: sendMessageModel);
    await _sendMessage(sendMessageModel: sendMessageModel);
  }

  Future<void> _sendMessage({
    required SendMessageModel sendMessageModel,
  }) async {
    final result = await chatRepo.sendMessage(
      sendMessageModel: sendMessageModel,
    );
    result.fold(
      (failure) => emit(
        state.copyWith(
          sendMessageErrorMessage: failure.errorMessage,
          sendMessageState: RequestStatus.error,
        ),
      ),
      (_) {
        emit(state.copyWith(sendMessageState: RequestStatus.success));
      },
    );
  }
}
