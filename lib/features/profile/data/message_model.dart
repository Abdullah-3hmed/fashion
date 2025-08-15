import 'package:equatable/equatable.dart';

class MessageModel extends Equatable {
  final int messageId;
  final int chatId;
  final String createdAt;
  final String senderId;
  final String receiverId;
  final String content;

  const MessageModel({
    required this.messageId,
    required this.chatId,
    required this.createdAt,
    required this.senderId,
    required this.receiverId,
    required this.content,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
    messageId: json["id"] ?? 0,
    chatId: json["chatId"] ?? 0,
    createdAt: json["createdAt"] ?? "",
    senderId: json["senderUserId"] ?? "",
    receiverId: json["receiverUserId"] ?? "",
    content: json["content"] ?? "",
  );

  @override
  List<Object?> get props => [
    messageId,
    chatId,
    createdAt,
    senderId,
    receiverId,
    content,
  ];
}
