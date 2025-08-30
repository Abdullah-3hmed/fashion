import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/features/profile/data/chat/message_model.dart';
import 'package:equatable/equatable.dart';

class ChatState extends Equatable {
  final RequestStatus getChatHistoryState;
  final List<MessageModel> messages;
  final String getChatHistoryErrorMessage;
  final RequestStatus sendMessageState;
  final String sendMessageErrorMessage;
  final bool isFirstLoad;

  const ChatState({
    this.getChatHistoryState = RequestStatus.loading,
    this.messages = const [],
    this.getChatHistoryErrorMessage = "",
    this.sendMessageState = RequestStatus.loading,
    this.sendMessageErrorMessage = "",
    this.isFirstLoad = false,
  });

  copyWith({
    RequestStatus? getChatHistoryState,
    List<MessageModel>? messages,
    String? getChatHistoryErrorMessage,
    RequestStatus? sendMessageState,
    String? sendMessageErrorMessage,
    bool? isFirstLoad,
  }) {
    return ChatState(
      getChatHistoryState: getChatHistoryState ?? this.getChatHistoryState,
      messages: messages ?? this.messages,
      getChatHistoryErrorMessage:
          getChatHistoryErrorMessage ?? this.getChatHistoryErrorMessage,
      sendMessageState: sendMessageState ?? this.sendMessageState,
      sendMessageErrorMessage:
          sendMessageErrorMessage ?? this.sendMessageErrorMessage,
      isFirstLoad: isFirstLoad ?? this.isFirstLoad,
    );
  }

  @override
  List<Object?> get props => [
    getChatHistoryState,
    messages,
    getChatHistoryErrorMessage,
    sendMessageState,
    sendMessageErrorMessage,
    isFirstLoad,
  ];
}
