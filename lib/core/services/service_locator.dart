import 'package:e_fashion_flutter/config/router/app_router.dart';
import 'package:get_it/get_it.dart';

// dependency injection
final GetIt getIt = GetIt.instance;

class ServiceLocator {
  void init() {
    getIt.registerSingleton<AppRouter>(AppRouter());
  }
}
