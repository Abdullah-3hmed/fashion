import 'dart:developer';

import 'package:e_fashion_flutter/core/network/api_constants.dart';
import 'package:e_fashion_flutter/core/utils/app_constants.dart';
import 'package:signalr_netcore/signalr_client.dart';

class ConnectionsService {
  static HubConnection? connection;

  static Future<void> initConnection() async {
    if (connection != null && connection!.state == HubConnectionState.Connected) return;
    try {
      final url = "http://shoping-online.runasp.net/chatHub";
      log("Connecting to: $url");
      connection =
          HubConnectionBuilder()
              .withUrl(
                url,
                options: HttpConnectionOptions(
                  requestTimeout: 5000,
                  accessTokenFactory: () async => AppConstants.token,
                  transport: HttpTransportType.WebSockets,
                ),
              )
              .withAutomaticReconnect()
              .build();

      await connection?.start();
      log("✅ Connection started");

      connection?.onclose(({error}) {
        log("⚠️ Connection closed${error != null ? ': $error' : ''}");
      });
    } catch (e, stackTrace) {
      log("❌ Error starting connection: $e");
      log("StackTrace: $stackTrace");
    }
  }

  static Future<void> checkConnection() async {
    if (connection?.state != HubConnectionState.Connected) {
      log("🔄 Re-initializing connection...");
      await initConnection();
    }
  }

  static Future<void> closeConnection() async {
    await connection?.stop();
    connection = null;
  }
}
