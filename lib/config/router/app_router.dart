import 'package:auto_route/auto_route.dart';
import 'package:e_fashion_flutter/features/splash_feature/screens/splash_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      initial: true,
      page: SplashTabRoute.page,
      children: [AutoRoute(initial: true, page: SplashRoute.page)],
    ),
    // AutoRoute(
    //   page: AuthRoute.page,
    //   children: [
    //     CustomRoute(
    //       initial: true,
    //       page: LoginRoute.page,
    //       transitionsBuilder: TransitionsBuilders.fadeIn,
    //       duration: const Duration(milliseconds: 300),
    //     ),
    //     CustomRoute(
    //       page: SignupRoute.page,
    //       transitionsBuilder: TransitionsBuilders.fadeIn,
    //       duration: const Duration(milliseconds: 300),
    //     ),
    //   ],
    // ),
  ];
}

@RoutePage(name: 'SplashTabRoute')
class Splash extends AutoRouter {
  const Splash({super.key});
}

// @RoutePage(name: 'AuthRoute')
// class Auth extends AutoRouter {
//   const Auth({super.key});
// }
