import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:e_fashion_flutter/config/router/app_router.dart';
import 'package:e_fashion_flutter/core/notifications/notification_controller.dart';
import 'package:e_fashion_flutter/core/services/service_locator.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class FcmInitHelper {
  static final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  static final AwesomeNotifications _awesomeNotifications =
      AwesomeNotifications();

  /// Request notification permission from the user
  static Future<bool> isNotificationAllowed() async {
    return await _awesomeNotifications.isNotificationAllowed();
  }

  static Future<void> requestPermission() async {
    await _awesomeNotifications.requestPermissionToSendNotifications();
  }

  static Future<void> initAwesomeNotification() async {
    await AwesomeNotifications().initialize(null, [
      NotificationChannel(
        channelKey: 'fcm_channel',
        channelName: 'Push Notifications',
        channelDescription: 'Notification channel for app push notifications',
        defaultColor: const Color(0xFF9D50DD),
        ledColor: const Color(0xFF9D50DD),
        importance: NotificationImportance.Max,
      ),
    ]);
  }

  /// Show notification manually (for foreground messages)
  static Future<void> _showAwesomeNotification(RemoteMessage message) async {
    await _awesomeNotifications.createNotification(
      content: NotificationContent(
        id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
        channelKey: 'fcm_channel',
        title: message.notification?.title ?? 'No title',
        body: message.notification?.body ?? 'No body',
        payload: {},
      ),
    );
  }

  static Future<void> setAwesomeNotificationListeners() async {
    await _awesomeNotifications.setListeners(
      onActionReceivedMethod: NotificationController.onActionReceivedMethod,
    );
  }

  /// Initialize FCM listeners
  static Future<void> initFirebaseMessagingListeners() async {
    // Foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint("📩 Foreground message: ${message.data}");
      final currentRouteName = getIt<AppRouter>().current.name;
      if (currentRouteName == ChatSupportRoute.name) {
        debugPrint("🔕 Notification suppressed: in ChatSupportRoute");
        return;
      }
      _showAwesomeNotification(message);
    });

    // Background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint("📲 Notification opened (background): ${message.data}");
      getIt<AppRouter>().navigate(const ChatSupportRoute());
    });

    RemoteMessage? message =
        await FcmInitHelper.firebaseMessaging.getInitialMessage();
    if (message != null) {
      debugPrint("🪦 App opened from terminated: ${message.data}");
      getIt<AppRouter>().navigate(const ChatSupportRoute());
    }
  }

  /// Get device token
  static Future<String?> getDeviceToken() async {
    final token = await firebaseMessaging.getToken();
    debugPrint("📱 Device FCM Token: $token");
    return token;
  }
}
