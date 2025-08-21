import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/features/profile/data/chat/message_model.dart';
import 'package:equatable/equatable.dart';

class ChatState extends Equatable {
  final RequestStatus getChatHistoryState;
  final List<MessageModel> messages;
  final String getChatHistoryErrorMessage;
  final RequestStatus sendMessageState;
  final String sendMessageErrorMessage;

  const ChatState({
    this.getChatHistoryState = RequestStatus.loading,
    this.messages = const [],
    this.getChatHistoryErrorMessage = "",
    this.sendMessageState = RequestStatus.loading,
    this.sendMessageErrorMessage = "",
  });

  copyWith({
    RequestStatus? getChatHistoryState,
    List<MessageModel>? messages,
    String? getChatHistoryErrorMessage,
    RequestStatus? sendMessageState,
    String? sendMessageErrorMessage,
  }) {
    return ChatState(
      getChatHistoryState: getChatHistoryState ?? this.getChatHistoryState,
      messages: messages ?? this.messages,
      getChatHistoryErrorMessage:
          getChatHistoryErrorMessage ?? this.getChatHistoryErrorMessage,
      sendMessageState: sendMessageState ?? this.sendMessageState,
      sendMessageErrorMessage:
          sendMessageErrorMessage ?? this.sendMessageErrorMessage,
    );
  }

  @override
  List<Object?> get props => [
    getChatHistoryState,
    messages,
    getChatHistoryErrorMessage,
    sendMessageState,
    sendMessageErrorMessage,
  ];
}
