import 'package:equatable/equatable.dart';

class SendMessageModel extends Equatable {
  final String senderId;
  final String receiverId;
  final String content;
  final int chatId;

  const SendMessageModel({
    required this.senderId,
    required this.receiverId,
    required this.content,
    required this.chatId,
  });

  Map<String, dynamic> toJson() =>
      {
        //"senderUserId": senderId,
        "receiverUserId": receiverId,
        "content": content,
        "chatId": chatId,
      };

  @override
  List<Object> get props => [senderId, receiverId, content, chatId];
}