import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/features/profile/data/chat/message_model.dart';
import 'package:equatable/equatable.dart';

class ChatState extends Equatable {
  final RequestStatus getChatHistoryState;
  final List<MessageModel> messageList;
  final String getChatHistoryErrorMessage;
  const ChatState({
     this.getChatHistoryState = RequestStatus.loading,
     this.messageList = const [],
     this.getChatHistoryErrorMessage = "",
  });
  copyWith({
    RequestStatus? getChatHistoryState,
    List<MessageModel>? messageList,
    String? getChatHistoryErrorMessage,
  }) {
    return ChatState(
      getChatHistoryState: getChatHistoryState ?? this.getChatHistoryState,
      messageList: messageList ?? this.messageList,
      getChatHistoryErrorMessage:
          getChatHistoryErrorMessage ?? this.getChatHistoryErrorMessage,
    );
  }

  @override
  List<Object?> get props => [getChatHistoryState, messageList, getChatHistoryErrorMessage];
}