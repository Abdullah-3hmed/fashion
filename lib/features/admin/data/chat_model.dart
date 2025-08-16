import 'package:equatable/equatable.dart';

class ChatModel extends Equatable {
  final int chatId;
  final String senderId;
  final String lastMessage;
  final String dateTime;
  final String userName;

  const ChatModel({
    required this.chatId,
    required this.senderId,
    required this.lastMessage,
    required this.dateTime,
    required this.userName,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
    chatId: json["chatId"] ?? 0,
    senderId: json["senderId"] ?? "",
    lastMessage: json["lastMessage"] ?? "",
    dateTime: json["dateTime"] ?? "",
    userName: json["userName"] ?? "",
  );

  @override
  List<Object> get props => [chatId, senderId, lastMessage, dateTime, userName];
}
