import 'package:auto_route/auto_route.dart';
import 'package:e_fashion_flutter/app_routes_observer.dart';
import 'package:e_fashion_flutter/config/router/app_router.dart';
import 'package:e_fashion_flutter/config/themes/theme_manager.dart';
import 'package:e_fashion_flutter/core/notifications/fcm_init_helper.dart';
import 'package:e_fashion_flutter/core/services/service_locator.dart';
import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    FcmInitHelper.initFirebaseMessagingListeners();
    FcmInitHelper.setAwesomeNotificationListeners();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeManager.darkTheme(),
      routerConfig: getIt<AppRouter>().config(
        navigatorObservers: () => [AppRoutesObserver(), AutoRouteObserver()],
      ),
    );
  }
}
