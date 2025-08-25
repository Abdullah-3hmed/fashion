import 'package:e_fashion_flutter/config/router/app_router.dart';
import 'package:e_fashion_flutter/core/local/cache_helper.dart';
import 'package:e_fashion_flutter/core/network/dio_helper.dart';
import 'package:e_fashion_flutter/core/network/network_info.dart';
import 'package:e_fashion_flutter/core/notifications/fcm_helper.dart';
import 'package:e_fashion_flutter/core/services/location_service.dart';
import 'package:e_fashion_flutter/core/services/signalr_service.dart';
import 'package:e_fashion_flutter/features/admin/admin_repo/admin_repo.dart';
import 'package:e_fashion_flutter/features/admin/admin_repo/admin_repo_impl.dart';
import 'package:e_fashion_flutter/features/admin/cubit/admin_cubit.dart';
import 'package:e_fashion_flutter/features/auth/cubit/auth_cubit.dart';
import 'package:e_fashion_flutter/features/auth/repos/auth_repo.dart';
import 'package:e_fashion_flutter/features/auth/repos/auth_repo_impl.dart';
import 'package:e_fashion_flutter/features/cart/cubit/cart_cubit.dart';
import 'package:e_fashion_flutter/features/cart/repo/cart_repo.dart';
import 'package:e_fashion_flutter/features/cart/repo/cart_repo_impl.dart';
import 'package:e_fashion_flutter/features/favourite/cubit/favorite_cubit.dart';
import 'package:e_fashion_flutter/features/favourite/repos/favorite_repo.dart';
import 'package:e_fashion_flutter/features/favourite/repos/favorite_repo_impl.dart';
import 'package:e_fashion_flutter/features/home/cubit/home_cubit.dart';
import 'package:e_fashion_flutter/features/home/cubit/product_details_cubit.dart';
import 'package:e_fashion_flutter/features/home/repos/home_details_repo/home_details_repo.dart';
import 'package:e_fashion_flutter/features/home/repos/home_details_repo/home_details_repo_impl.dart';
import 'package:e_fashion_flutter/features/home/repos/home_repo/home_repo.dart';
import 'package:e_fashion_flutter/features/home/repos/home_repo/home_repo_impl.dart';
import 'package:e_fashion_flutter/features/notification/repo/notification_repo.dart';
import 'package:e_fashion_flutter/features/notification/repo/notification_repo_impl.dart';
import 'package:e_fashion_flutter/features/profile/cubit/chat_cubit/chat_cubit.dart';
import 'package:e_fashion_flutter/features/profile/cubit/map_cubit/map_cubit.dart';
import 'package:e_fashion_flutter/features/profile/cubit/user_cubit/user_cubit.dart';
import 'package:e_fashion_flutter/features/profile/repos/chat_repo/chat_repo.dart';
import 'package:e_fashion_flutter/features/profile/repos/chat_repo/chat_repo_impl.dart';
import 'package:e_fashion_flutter/features/profile/repos/map_repo/map_repo.dart';
import 'package:e_fashion_flutter/features/profile/repos/map_repo/map_repo_impl.dart';
import 'package:e_fashion_flutter/features/profile/repos/user_repo/user_repo.dart';
import 'package:e_fashion_flutter/features/profile/repos/user_repo/user_repo_impl.dart';
import 'package:e_fashion_flutter/features/search/bloc/search_bloc.dart';
import 'package:e_fashion_flutter/features/search/repo/search_repo.dart';
import 'package:e_fashion_flutter/shared/app_cubit/app_cubit.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

// dependency injection
final GetIt getIt = GetIt.instance;

class ServiceLocator {
  void init() {
    getIt.registerSingleton<AppRouter>(AppRouter());
    //getIt.registerLazySingleton<FcmHelper>(() => FcmHelper());
    getIt.registerLazySingleton<FlutterSecureStorage>(
      () => const FlutterSecureStorage(),
    );
    getIt.registerLazySingleton<CacheHelper>(() => CacheHelper());
    getIt.registerLazySingleton<DioHelper>(() => DioHelper());
    getIt.registerLazySingleton<AuthRepo>(
      () => AuthRepoImpl(dioHelper: getIt<DioHelper>()),
    );
    getIt.registerFactory<AuthCubit>(() => AuthCubit(getIt<AuthRepo>()));
    getIt.registerLazySingleton<UserRepo>(
      () => UserRepoImpl(dioHelper: getIt<DioHelper>()),
    );
    getIt.registerFactory<UserCubit>(
      () => UserCubit(userRepo: getIt<UserRepo>()),
    );
    getIt.registerLazySingleton<LocationService>(() => LocationService());
    getIt.registerLazySingleton<MapRepo>(() => MapRepoImpl());
    getIt.registerFactory<MapCubit>(() => MapCubit(mapRepo: getIt<MapRepo>()));
    getIt.registerLazySingleton<HomeRepo>(
      () => HomeRepoImpl(dioHelper: getIt<DioHelper>()),
    );
    getIt.registerLazySingleton<HomeDetailsRepo>(
      () => HomeDetailsRepoImpl(dioHelper: getIt<DioHelper>()),
    );
    getIt.registerFactory<HomeCubit>(
      () => HomeCubit(homeRepo: getIt<HomeRepo>()),
    );
    getIt.registerFactory<ProductDetailsCubit>(
      () => ProductDetailsCubit(homeDetailsRepo: getIt<HomeDetailsRepo>()),
    );
    getIt.registerLazySingleton<SearchRepo>(
      () => SearchRepo(dioHelper: getIt<DioHelper>()),
    );
    getIt.registerFactory<SearchBloc>(
      () => SearchBloc(searchRepo: getIt<SearchRepo>()),
    );
    getIt.registerLazySingleton<FavoriteRepo>(
      () => FavoriteRepoImpl(dioHelper: getIt<DioHelper>()),
    );
    getIt.registerFactory<FavoriteCubit>(
      () => FavoriteCubit(favoriteRepo: getIt<FavoriteRepo>()),
    );
    getIt.registerLazySingleton<CartRepo>(
      () => CartRepoImpl(dioHelper: getIt<DioHelper>()),
    );
    getIt.registerFactory<CartCubit>(
      () => CartCubit(cartRepo: getIt<CartRepo>()),
    );
    getIt.registerLazySingleton<NotificationRepo>(
      () => NotificationRepoImpl(dioHelper: getIt<DioHelper>()),
    );
    getIt.registerFactory<AppCubit>(() => AppCubit(
      notificationRepo: getIt<NotificationRepo>(),
    ));
    getIt.registerLazySingleton<AdminRepo>(
      () => AdminRepoImpl(dioHelper: getIt<DioHelper>()),
    );
    getIt.registerFactory<AdminCubit>(
      () => AdminCubit(adminRepo: getIt<AdminRepo>()),
    );
    getIt.registerLazySingleton<SignalrService>(() => SignalrService());
    getIt.registerLazySingleton<ChatRepo>(
      () => ChatRepoImpl(dioHelper: getIt<DioHelper>()),
    );
    getIt.registerFactory<ChatCubit>(
      () => ChatCubit(
        signalrService: getIt<SignalrService>(),
        chatRepo: getIt<ChatRepo>(),
      ),
    );
  }
}
