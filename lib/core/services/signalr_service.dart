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
        "MessageSent",
        args: [sendMessageModel.toJson()],
      );
      log("✅ Message sent successfully: ${sendMessageModel.toJson()}");
    } catch (error, stackTrace) {
      log("❌ Error sending message: $error");
      log("StackTrace: $stackTrace");
      rethrow;
    }
  }

  Future<void> listenToMessages(OnMessageReceived onMessage) async {
    await ConnectionsService.checkConnection();
    ConnectionsService.connection.off("ReceiveMessage");

    ConnectionsService.connection.on("ReceiveMessage", (arguments) {
      try {
        if (arguments != null && arguments.isNotEmpty) {
          final data = arguments[0];

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
}
