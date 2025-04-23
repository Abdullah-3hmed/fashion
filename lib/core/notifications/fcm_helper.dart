import 'package:e_fashion_flutter/core/network/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;

class FcmHelper {
  Future<String> _getAccessToken() async {
    final jsonString = await rootBundle.loadString(
      'assets/notifications_key/e-fashion-f1215-da0bb632d3c1.json',
    );

    final accountCredentials = auth.ServiceAccountCredentials.fromJson(
      jsonString,
    );

    final scopes = ['https://www.googleapis.com/auth/firebase.messaging'];
    final client = await auth.clientViaServiceAccount(
      accountCredentials,
      scopes,
    );

    return client.credentials.accessToken.data;
  }

  Future<void> sendNotification({
    required String token,
    required String title,
    required String body,
    required Map<String, String> data,
  }) async {
    final String fcmUrl =
        'https://fcm.googleapis.com/v1/projects/e-fashion-f1215/messages:send';
    String accessToken = await _getAccessToken();

    final response = await DioHelper.post(
      fcmUrl,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      data: <String, dynamic>{
        'message': {
          'token': token,
          'notification': {'title': title, 'body': body},
          'data': {"channelKey": "fcm_channel"}, // Add custom data here
          'android': {
            'notification': {
              "sound": "custom_sound",
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              // Required for tapping to trigger response
              'channel_id': 'fcm_channel',
            },
          },
          'apns': {
            'payload': {
              'aps': {"sound": "custom_sound.caf", 'content-available': 1},
            },
          },
        },
      },
    );

    if (response.statusCode == 200) {
      debugPrint('Notification sent successfully');
    } else {
      debugPrint('Failed to send notification: ${response.data}');
    }
  }
}
