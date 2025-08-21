import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:e_fashion_flutter/core/services/service_locator.dart';
import 'package:e_fashion_flutter/features/admin/screens/all_chats_screen.dart';
import 'package:e_fashion_flutter/features/auth/cubit/auth_cubit.dart';
import 'package:e_fashion_flutter/features/auth/screens/email_verification_screen.dart';
import 'package:e_fashion_flutter/features/auth/screens/forget_password_screen.dart';
import 'package:e_fashion_flutter/features/auth/screens/login_screen.dart';
import 'package:e_fashion_flutter/features/auth/screens/reset_password_screen.dart';
import 'package:e_fashion_flutter/features/auth/screens/sign_up_screen.dart';
import 'package:e_fashion_flutter/features/bottom_vav_bar/layout_screen.dart';
import 'package:e_fashion_flutter/features/cart/cubit/cart_cubit.dart';
import 'package:e_fashion_flutter/features/cart/screens/cart_screen.dart';
import 'package:e_fashion_flutter/features/cart/screens/widgets/payment_success_screen.dart';
import 'package:e_fashion_flutter/features/favourite/cubit/favorite_cubit.dart';
import 'package:e_fashion_flutter/features/favourite/screens/favorite_screen.dart';
import 'package:e_fashion_flutter/features/home/cubit/home_cubit.dart';
import 'package:e_fashion_flutter/features/home/cubit/product_details_cubit.dart';
import 'package:e_fashion_flutter/features/home/data/home_details/product_details_model.dart';
import 'package:e_fashion_flutter/features/home/screens/collection_screen.dart';
import 'package:e_fashion_flutter/features/home/screens/discover_screen.dart';
import 'package:e_fashion_flutter/features/home/screens/edit_review_screen.dart';
import 'package:e_fashion_flutter/features/home/screens/home_screen.dart';
import 'package:e_fashion_flutter/features/home/screens/product_details_screen.dart';
import 'package:e_fashion_flutter/features/notification/screens/notification_screen.dart';
import 'package:e_fashion_flutter/features/profile/cubit/chat_cubit/chat_cubit.dart';
import 'package:e_fashion_flutter/features/profile/cubit/user_cubit/user_cubit.dart';
import 'package:e_fashion_flutter/features/profile/screens/chat_support_screen.dart';
import 'package:e_fashion_flutter/features/profile/screens/edit_profile_screen.dart';
import 'package:e_fashion_flutter/features/profile/screens/map_screen.dart';
import 'package:e_fashion_flutter/features/profile/screens/order_status_screen.dart';
import 'package:e_fashion_flutter/features/profile/screens/profile_change_password_screen.dart';
import 'package:e_fashion_flutter/features/profile/screens/profile_screen.dart';
import 'package:e_fashion_flutter/features/search/screens/search_screen.dart';
import 'package:e_fashion_flutter/features/splash/screens/splash_screen.dart';
import 'package:e_fashion_flutter/shared/data/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes =>
      [
        AutoRoute(
          initial: true,
          page: SplashTabRoute.page,
          children: [AutoRoute(initial: true, page: SplashRoute.page)],
        ),
        AutoRoute(
          page: AuthRoute.page,
          children: [
            _buildCustomRoute(initial: true, page: LoginRoute.page),
            _buildCustomRoute(page: SignUpRoute.page),
            _buildCustomRoute(page: ForgetPasswordRoute.page),
            _buildCustomRoute(page: EmailVerificationRoute.page),
            _buildCustomRoute(page: ResetPasswordRoute.page),
          ],
        ),
        _buildCustomRoute(
          page: AuthenticatedRoute.page,
          children: [
            _buildCustomRoute(page: ChatSupportRoute.page),
            _buildCustomRoute(
              initial: true,
              page: LayoutRoute.page,
              children: [
                // _buildCustomRoute(
                //   initial: true,
                //   page: HomeTabRoute.page,
                //   children: [
                //     _buildCustomRoute(initial: true, page: HomeRoute.page),
                //     _buildCustomRoute(page: CollectionRoute.page),
                //   ],
                // ),
                _buildCustomRoute(initial: true, page: HomeRoute.page),
                _buildCustomRoute(page: CartRoute.page),
                _buildCustomRoute(page: FavoriteRoute.page),
                _buildCustomRoute(page: ProfileRoute.page),
              ],
            ),
            _buildCustomRoute(page: CollectionRoute.page),
            _buildCustomRoute(page: ProductDetailsRoute.page),
            _buildCustomRoute(page: EditProfileRoute.page),
            _buildCustomRoute(page: ProfileChangePasswordRoute.page),
            _buildCustomRoute(page: OrderStatusRoute.page),
            _buildCustomRoute(page: EditReviewRoute.page),
            _buildCustomRoute(page: DiscoverRoute.page),
            _buildCustomRoute(page: SearchRoute.page),
            _buildCustomRoute(page: NotificationRoute.page),
            _buildCustomRoute(page: MapRoute.page),
            _buildCustomRoute(page: PaymentSuccessRoute.page),
            _buildCustomRoute(page: AllChatsRoute.page),
          ],
        ),
      ];

  CustomRoute _buildCustomRoute({
    bool initial = false,
    required PageInfo page,
    List<AutoRoute>? children,
  }) {
    return CustomRoute(
      initial: initial,
      page: page,
      transitionsBuilder: TransitionsBuilders.fadeIn,
      duration: const Duration(milliseconds: 300),
      children: children,
    );
  }
}

@RoutePage(name: 'SplashTabRoute')
class Splash extends AutoRouter {
  const Splash({super.key});
}

@RoutePage(name: 'AuthRoute')
class Auth extends AutoRouter implements AutoRouteWrapper {
  const Auth({super.key});

  @override
  Widget wrappedRoute(BuildContext context) =>
      BlocProvider(
        create: (context) => getIt<AuthCubit>(),
        child: this,
      );
}

@RoutePage(name: 'AuthenticatedRoute')
class Authenticated extends AutoRouter implements AutoRouteWrapper {
  const Authenticated({super.key});

  @override
  Widget wrappedRoute(BuildContext context) =>
      MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
            getIt<UserCubit>()
              ..getUserProfile(),
          ),
          BlocProvider(
            create: (context) =>
            getIt<FavoriteCubit>()
              ..getFavorites(),
          ),
          BlocProvider(
            create: (context) =>
            getIt<CartCubit>()
              ..getCartItems(),
          ),
          BlocProvider(
            create: (context) =>
            getIt<ChatCubit>(),
          ),
        ],
        child: this,
      );
}

// @RoutePage(name: 'HomeTabRoute')
// class HomeTab extends AutoRouter {
//   const HomeTab({super.key});
// }

@RoutePage(name: 'CartRoute')
class Cart extends AutoRouter {
  const Cart({super.key});
}

@RoutePage(name: 'FavoriteRoute')
class Favorite extends AutoRouter {
  const Favorite({super.key});
}

@RoutePage(name: 'ProfileRoute')
class Profile extends AutoRouter {
  const Profile({super.key});
}
