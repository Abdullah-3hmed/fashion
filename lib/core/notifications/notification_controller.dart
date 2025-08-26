import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:e_fashion_flutter/core/notifications/navigate_to_chat.dart';

class NotificationController {
  @pragma('vm:entry-point')
  static Future<void> onActionReceivedMethod(
    ReceivedAction receivedAction,
  ) async {
    //if(receivedAction.payload?["type"] == "message") return;
    await navigateToChat();
  }
}
