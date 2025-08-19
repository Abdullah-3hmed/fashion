import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/features/profile/data/chat/message_model.dart';
import 'package:equatable/equatable.dart';

class ChatState extends Equatable {
  final RequestStatus getChatHistoryState;
  final List<MessageModel> messageList;
  final String getChatHistoryErrorMessage;
  final RequestStatus sendMessageState;
  final String sendMessageErrorMessage;
  const ChatState({
     this.getChatHistoryState = RequestStatus.loading,
     this.messageList = const [],
     this.getChatHistoryErrorMessage = "",
     this.sendMessageState = RequestStatus.loading,
     this.sendMessageErrorMessage = "",
  });
  copyWith({
    RequestStatus? getChatHistoryState,
    List<MessageModel>? messageList,
    String? getChatHistoryErrorMessage,
    RequestStatus? sendMessageState,
    String? sendMessageErrorMessage
  }) {
    return ChatState(
      getChatHistoryState: getChatHistoryState ?? this.getChatHistoryState,
      messageList: messageList ?? this.messageList,
      getChatHistoryErrorMessage:
          getChatHistoryErrorMessage ?? this.getChatHistoryErrorMessage,
      sendMessageState: sendMessageState ?? this.sendMessageState,
      sendMessageErrorMessage: sendMessageErrorMessage ?? this.sendMessageErrorMessage
    );
  }

  @override
  List<Object?> get props => [getChatHistoryState, messageList, getChatHistoryErrorMessage, sendMessageState, sendMessageErrorMessage];
}