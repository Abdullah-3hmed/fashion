import 'dart:developer';

import 'package:e_fashion_flutter/core/utils/app_constants.dart';
import 'package:signalr_netcore/http_connection_options.dart';
import 'package:signalr_netcore/hub_connection.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';

class ConnectionsServices {
  static late HubConnection connection;

  static Future<void> initConnection() async {
    if (AppConstants.token.isEmpty) return;
    connection =
        HubConnectionBuilder()
            .withUrl(
         // "${ApiEndPoints.chatServices}$token",
          "",
          options: HttpConnectionOptions(requestTimeout: 5000),
        )
            .withAutomaticReconnect()
            .build();

    await connection
        .start()
        ?.then((value) {
      log("Connection started");
    })
        .catchError((error) {
      log("Error starting connection: $error");
    });

    connection.onclose(({error}) {
      log("Connection closed${error != null ? ': $error' : ''}");
      // Optional: Try reconnecting or alert the user
    });
  }

  static void onConnectionClosed() {
    connection.onclose(({error}) {
      log("Connection closed${error != null ? ': $error' : ''}");
    });
  }

  static Future<void> checkConnection() async {
    if (connection.state != HubConnectionState.Connected) {
      log("I init Connections");
      await initConnection();
    }
  }
}