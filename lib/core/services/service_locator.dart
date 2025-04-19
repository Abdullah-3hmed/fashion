import 'package:e_fashion_flutter/config/router/app_router.dart';
import 'package:e_fashion_flutter/core/network/network_info.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

// dependency injection
final GetIt getIt = GetIt.instance;

class ServiceLocator {
  void init() {
    getIt.registerSingleton<AppRouter>(AppRouter());
    getIt.registerLazySingleton<InternetConnection>(() => InternetConnection());
    getIt.registerLazySingleton<NetworkInfo>(
      () => NetworkInfo(internetConnection: getIt<InternetConnection>()),
    );
  }
}
