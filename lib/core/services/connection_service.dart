import 'dart:developer';

import 'package:e_fashion_flutter/core/network/api_constants.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:signalr_netcore/http_connection_options.dart';
import 'package:signalr_netcore/hub_connection.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';

class ConnectionsService {
  static late HubConnection connection;

  static Future<void> initConnection() async {
    try {
      final url = "${dotenv.env["API_URL"]!}${ApiConstants.sendMessageEndpoint}";
      log("Connecting to: $url");
      connection = HubConnectionBuilder()
          .withUrl(
        url,
        options: HttpConnectionOptions(requestTimeout: 5000),
      )
          .withAutomaticReconnect()
          .build();

      await connection.start();
      log("✅ Connection started");

      connection.onclose(({error}) {
        log("⚠️ Connection closed${error != null ? ': $error' : ''}");
        // Optional: إعادة المحاولة أو تنبيه المستخدم
      });
    } catch (e, stackTrace) {
      log("❌ Error starting connection: $e");
      log("StackTrace: $stackTrace");
    }
  }

  static void onConnectionClosed() {
    connection.onclose(({error}) {
      log("⚠️ Connection closed${error != null ? ': $error' : ''}");
    });
  }

  static Future<void> checkConnection() async {
    if (connection.state != HubConnectionState.Connected) {
      log("🔄 Re-initializing connection...");
      await initConnection();
    }
  }
}
