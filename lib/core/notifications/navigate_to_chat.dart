import 'package:e_fashion_flutter/config/router/app_router.dart';
import 'package:e_fashion_flutter/core/services/service_locator.dart';
import 'package:e_fashion_flutter/core/utils/app_constants.dart';

Future<void> navigateToChat() async {
  final String currentRoute = getIt<AppRouter>().current.name;
  if (currentRoute == SplashTabRoute.name) {
    await getIt<AppRouter>().replaceAll([
      const AuthenticatedRoute(children: [LayoutRoute()]),
    ]);
    getIt<AppRouter>().navigate(
      ChatSupportRoute(receiverId: AppConstants.supportId),
    );
  } else if (currentRoute == AuthenticatedRoute.name ||
      currentRoute == LayoutRoute.name) {
    await getIt<AppRouter>().navigate(
      ChatSupportRoute(receiverId: AppConstants.supportId),
    );
  }
}
