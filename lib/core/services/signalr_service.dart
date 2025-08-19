import 'dart:developer';
import 'package:e_fashion_flutter/core/services/connection_service.dart';
import 'package:e_fashion_flutter/features/profile/data/chat/message_model.dart';
import 'package:e_fashion_flutter/features/profile/data/chat/send_message_model.dart';

typedef OnMessageReceived = void Function(MessageModel message);

class SignalrService {
  Future<void> sendMessage({required SendMessageModel sendMessageModel}) async {
    await ConnectionsService.checkConnection();
    try {
      await ConnectionsService.connection.invoke(
        "SendMessage",
        args: [
          sendMessageModel.senderId,
          sendMessageModel.receiverId,
          sendMessageModel.content,
        ],
      );
      log("✅ Message sent successfully: ${sendMessageModel.toJson()}");
    } catch (error, stackTrace) {
      log("❌ Error sending message: $error");
      log("StackTrace: $stackTrace");
      rethrow;
    }
  }

  Future<void> listenToMessages(OnMessageReceived onMessage) async {
    log("Listening to messages...");
    await ConnectionsService.checkConnection();
    ConnectionsService.connection.off("ReceiveMessage");

    ConnectionsService.connection.on("ReceiveMessage", (arguments) {
      try {
        if (arguments != null && arguments.isNotEmpty) {
          final data = arguments[0];
          log("Received data: $data");

          if (data is Map) {
            final jsonData = Map<String, dynamic>.from(data);
            final message = MessageModel.fromJson(jsonData);

            onMessage(message);
            log("📩 New message received: ${message.toString()}");
          } else {
            log("⚠️ Received data is not a valid map: $data");
          }
        }
      } catch (e, stackTrace) {
        log("❌ Error handling incoming message: $e");
        log("StackTrace: $stackTrace");
      }
    });
  }
  Future<void> listenToSentMessages(OnMessageReceived onMessageSent) async {
    log("Listening to sent messages...");
    await ConnectionsService.checkConnection();
    ConnectionsService.connection.off("MessageSent");

    ConnectionsService.connection.on("MessageSent", (arguments) {
      try {
        if (arguments != null && arguments.isNotEmpty) {
          final data = arguments[0];
          log("Sent event data: $data");

          if (data is Map) {
            final jsonData = Map<String, dynamic>.from(data);
            final message = MessageModel.fromJson(jsonData);

            onMessageSent(message);
            log("📤 Message confirmed sent: ${message.toString()}");
          } else {
            log("⚠️ Sent event is not a valid map: $data");
          }
        }
      } catch (e, stackTrace) {
        log("❌ Error handling sent message: $e");
        log("StackTrace: $stackTrace");
      }
    });
  }

}
