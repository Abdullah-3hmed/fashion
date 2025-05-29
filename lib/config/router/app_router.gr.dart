// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [Auth]
class AuthRoute extends PageRouteInfo<void> {
  const AuthRoute({List<PageRouteInfo>? children})
    : super(AuthRoute.name, initialChildren: children);

  static const String name = 'AuthRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const Auth());
    },
  );
}

/// generated route for
/// [Authenticated]
class AuthenticatedRoute extends PageRouteInfo<void> {
  const AuthenticatedRoute({List<PageRouteInfo>? children})
    : super(AuthenticatedRoute.name, initialChildren: children);

  static const String name = 'AuthenticatedRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const Authenticated());
    },
  );
}

/// generated route for
/// [CartScreen]
class CartRoute extends PageRouteInfo<void> {
  const CartRoute({List<PageRouteInfo>? children})
    : super(CartRoute.name, initialChildren: children);

  static const String name = 'CartRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const CartScreen();
    },
  );
}

/// generated route for
/// [ChatSupportScreen]
class ChatSupportRoute extends PageRouteInfo<void> {
  const ChatSupportRoute({List<PageRouteInfo>? children})
    : super(ChatSupportRoute.name, initialChildren: children);

  static const String name = 'ChatSupportRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ChatSupportScreen();
    },
  );
}

/// generated route for
/// [CollectionScreen]
class CollectionRoute extends PageRouteInfo<CollectionRouteArgs> {
  CollectionRoute({
    Key? key,
    required String collectionName,
    List<PageRouteInfo>? children,
  }) : super(
         CollectionRoute.name,
         args: CollectionRouteArgs(key: key, collectionName: collectionName),
         initialChildren: children,
       );

  static const String name = 'CollectionRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CollectionRouteArgs>();
      return CollectionScreen(
        key: args.key,
        collectionName: args.collectionName,
      );
    },
  );
}

class CollectionRouteArgs {
  const CollectionRouteArgs({this.key, required this.collectionName});

  final Key? key;

  final String collectionName;

  @override
  String toString() {
    return 'CollectionRouteArgs{key: $key, collectionName: $collectionName}';
  }
}

/// generated route for
/// [DiscoverScreen]
class DiscoverRoute extends PageRouteInfo<DiscoverRouteArgs> {
  DiscoverRoute({Key? key, bool isOffer = false, List<PageRouteInfo>? children})
    : super(
        DiscoverRoute.name,
        args: DiscoverRouteArgs(key: key, isOffer: isOffer),
        initialChildren: children,
      );

  static const String name = 'DiscoverRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<DiscoverRouteArgs>(
        orElse: () => const DiscoverRouteArgs(),
      );
      return DiscoverScreen(key: args.key, isOffer: args.isOffer);
    },
  );
}

class DiscoverRouteArgs {
  const DiscoverRouteArgs({this.key, this.isOffer = false});

  final Key? key;

  final bool isOffer;

  @override
  String toString() {
    return 'DiscoverRouteArgs{key: $key, isOffer: $isOffer}';
  }
}

/// generated route for
/// [EditProfileScreen]
class EditProfileRoute extends PageRouteInfo<void> {
  const EditProfileRoute({List<PageRouteInfo>? children})
    : super(EditProfileRoute.name, initialChildren: children);

  static const String name = 'EditProfileRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const EditProfileScreen();
    },
  );
}

/// generated route for
/// [EditReviewScreen]
class EditReviewRoute extends PageRouteInfo<EditReviewRouteArgs> {
  EditReviewRoute({
    Key? key,
    required ProductDetailsModel productDetailsModel,
    List<PageRouteInfo>? children,
  }) : super(
         EditReviewRoute.name,
         args: EditReviewRouteArgs(
           key: key,
           productDetailsModel: productDetailsModel,
         ),
         initialChildren: children,
       );

  static const String name = 'EditReviewRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EditReviewRouteArgs>();
      return EditReviewScreen(
        key: args.key,
        productDetailsModel: args.productDetailsModel,
      );
    },
  );
}

class EditReviewRouteArgs {
  const EditReviewRouteArgs({this.key, required this.productDetailsModel});

  final Key? key;

  final ProductDetailsModel productDetailsModel;

  @override
  String toString() {
    return 'EditReviewRouteArgs{key: $key, productDetailsModel: $productDetailsModel}';
  }
}

/// generated route for
/// [EmailVerificationScreen]
class EmailVerificationRoute extends PageRouteInfo<void> {
  const EmailVerificationRoute({List<PageRouteInfo>? children})
    : super(EmailVerificationRoute.name, initialChildren: children);

  static const String name = 'EmailVerificationRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const EmailVerificationScreen();
    },
  );
}

/// generated route for
/// [FavoriteScreen]
class FavoriteRoute extends PageRouteInfo<void> {
  const FavoriteRoute({List<PageRouteInfo>? children})
    : super(FavoriteRoute.name, initialChildren: children);

  static const String name = 'FavoriteRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const FavoriteScreen();
    },
  );
}

/// generated route for
/// [ForgetPasswordScreen]
class ForgetPasswordRoute extends PageRouteInfo<void> {
  const ForgetPasswordRoute({List<PageRouteInfo>? children})
    : super(ForgetPasswordRoute.name, initialChildren: children);

  static const String name = 'ForgetPasswordRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ForgetPasswordScreen();
    },
  );
}

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomeScreen();
    },
  );
}

/// generated route for
/// [HomeTab]
class HomeTabRoute extends PageRouteInfo<void> {
  const HomeTabRoute({List<PageRouteInfo>? children})
    : super(HomeTabRoute.name, initialChildren: children);

  static const String name = 'HomeTabRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomeTab();
    },
  );
}

/// generated route for
/// [LayoutScreen]
class LayoutRoute extends PageRouteInfo<void> {
  const LayoutRoute({List<PageRouteInfo>? children})
    : super(LayoutRoute.name, initialChildren: children);

  static const String name = 'LayoutRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const LayoutScreen();
    },
  );
}

/// generated route for
/// [LoginScreen]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const LoginScreen();
    },
  );
}

/// generated route for
/// [MapScreen]
class MapRoute extends PageRouteInfo<void> {
  const MapRoute({List<PageRouteInfo>? children})
    : super(MapRoute.name, initialChildren: children);

  static const String name = 'MapRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const MapScreen());
    },
  );
}

/// generated route for
/// [NotificationScreen]
class NotificationRoute extends PageRouteInfo<void> {
  const NotificationRoute({List<PageRouteInfo>? children})
    : super(NotificationRoute.name, initialChildren: children);

  static const String name = 'NotificationRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const NotificationScreen();
    },
  );
}

/// generated route for
/// [OrderStatusScreen]
class OrderStatusRoute extends PageRouteInfo<void> {
  const OrderStatusRoute({List<PageRouteInfo>? children})
    : super(OrderStatusRoute.name, initialChildren: children);

  static const String name = 'OrderStatusRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const OrderStatusScreen();
    },
  );
}

/// generated route for
/// [PaymentSuccessScreen]
class PaymentSuccessRoute extends PageRouteInfo<void> {
  const PaymentSuccessRoute({List<PageRouteInfo>? children})
    : super(PaymentSuccessRoute.name, initialChildren: children);

  static const String name = 'PaymentSuccessRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const PaymentSuccessScreen();
    },
  );
}

/// generated route for
/// [ProductDetailsScreen]
class ProductDetailsRoute extends PageRouteInfo<ProductDetailsRouteArgs> {
  ProductDetailsRoute({
    Key? key,
    required String imageUrl,
    required int productId,
    List<PageRouteInfo>? children,
  }) : super(
         ProductDetailsRoute.name,
         args: ProductDetailsRouteArgs(
           key: key,
           imageUrl: imageUrl,
           productId: productId,
         ),
         initialChildren: children,
       );

  static const String name = 'ProductDetailsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ProductDetailsRouteArgs>();
      return ProductDetailsScreen(
        key: args.key,
        imageUrl: args.imageUrl,
        productId: args.productId,
      );
    },
  );
}

class ProductDetailsRouteArgs {
  const ProductDetailsRouteArgs({
    this.key,
    required this.imageUrl,
    required this.productId,
  });

  final Key? key;

  final String imageUrl;

  final int productId;

  @override
  String toString() {
    return 'ProductDetailsRouteArgs{key: $key, imageUrl: $imageUrl, productId: $productId}';
  }
}

/// generated route for
/// [ProfileScreen]
class ProfileRoute extends PageRouteInfo<void> {
  const ProfileRoute({List<PageRouteInfo>? children})
    : super(ProfileRoute.name, initialChildren: children);

  static const String name = 'ProfileRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ProfileScreen();
    },
  );
}

/// generated route for
/// [ProfileChangePasswordScreen]
class ProfileChangePasswordRoute extends PageRouteInfo<void> {
  const ProfileChangePasswordRoute({List<PageRouteInfo>? children})
    : super(ProfileChangePasswordRoute.name, initialChildren: children);

  static const String name = 'ProfileChangePasswordRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ProfileChangePasswordScreen();
    },
  );
}

/// generated route for
/// [ResetPasswordScreen]
class ResetPasswordRoute extends PageRouteInfo<void> {
  const ResetPasswordRoute({List<PageRouteInfo>? children})
    : super(ResetPasswordRoute.name, initialChildren: children);

  static const String name = 'ResetPasswordRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ResetPasswordScreen();
    },
  );
}

/// generated route for
/// [SearchScreen]
class SearchRoute extends PageRouteInfo<void> {
  const SearchRoute({List<PageRouteInfo>? children})
    : super(SearchRoute.name, initialChildren: children);

  static const String name = 'SearchRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const SearchScreen());
    },
  );
}

/// generated route for
/// [SignUpScreen]
class SignUpRoute extends PageRouteInfo<void> {
  const SignUpRoute({List<PageRouteInfo>? children})
    : super(SignUpRoute.name, initialChildren: children);

  static const String name = 'SignUpRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SignUpScreen();
    },
  );
}

/// generated route for
/// [Splash]
class SplashTabRoute extends PageRouteInfo<void> {
  const SplashTabRoute({List<PageRouteInfo>? children})
    : super(SplashTabRoute.name, initialChildren: children);

  static const String name = 'SplashTabRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const Splash();
    },
  );
}

/// generated route for
/// [SplashScreen]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute({List<PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SplashScreen();
    },
  );
}
