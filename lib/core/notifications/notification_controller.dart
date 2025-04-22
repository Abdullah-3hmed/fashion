import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:e_fashion_flutter/config/router/app_router.dart';
import 'package:e_fashion_flutter/core/services/service_locator.dart';

class NotificationController {
  @pragma('vm:entry-point')
  static Future<void> onActionReceivedMethod(
    ReceivedAction receivedAction,
  ) async {
    getIt<AppRouter>().navigate(const ChatSupportRoute());
  }
}
