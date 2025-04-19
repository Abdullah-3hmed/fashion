import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class NetworkInfo {
  final InternetConnection internetConnection;
  NetworkInfo({required this.internetConnection});
  Future<bool> get isConnected async =>
      await internetConnection.hasInternetAccess;

  Stream<InternetStatus> get onStatusChange =>
      internetConnection.onStatusChange;
}
