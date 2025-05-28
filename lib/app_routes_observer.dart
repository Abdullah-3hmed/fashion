import 'package:auto_route/auto_route.dart';
import 'package:e_fashion_flutter/core/utils/app_constants.dart';
import 'package:flutter/material.dart';

class AppRoutesObserver extends AutoRouterObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    AppConstants.currentRoute = route.settings.name ?? "";
    debugPrint('[INFO] New route pushed: ${route.settings.name}');
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    AppConstants.currentRoute = previousRoute?.settings.name ?? "";
    debugPrint('[INFO] Route Popped : ${route.settings.name}');
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    AppConstants.currentRoute = previousRoute?.settings.name ?? "";
    debugPrint('[INFO] Route Removed : ${route.settings.name}');
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    AppConstants.currentRoute = newRoute!.settings.name ?? "";
    debugPrint(
      '[INFO] OldRoute : ${oldRoute!.settings.name} was replaced by ${newRoute.settings.name}',
    );
  }

  @override
  void didInitTabRoute(TabPageRoute route, TabPageRoute? previousRoute) {
    AppConstants.currentRoute = route.name;
    debugPrint('[INFO] Tab route visited: ${route.name}');
  }

  @override
  void didChangeTabRoute(TabPageRoute route, TabPageRoute previousRoute) {
    AppConstants.currentRoute = route.name;
    debugPrint('[INFO] Tab route re-visited: ${route.name}');
  }
}
