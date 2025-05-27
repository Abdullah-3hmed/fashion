import 'package:e_fashion_flutter/config/router/app_router.dart';
import 'package:e_fashion_flutter/core/local/cache_helper.dart';
import 'package:e_fashion_flutter/core/network/dio_helper.dart';
import 'package:e_fashion_flutter/core/network/network_info.dart';
import 'package:e_fashion_flutter/core/notifications/fcm_helper.dart';
import 'package:e_fashion_flutter/core/services/location_service.dart';
import 'package:e_fashion_flutter/features/auth/cubit/auth_cubit.dart';
import 'package:e_fashion_flutter/features/auth/repos/auth_repo.dart';
import 'package:e_fashion_flutter/features/auth/repos/auth_repo_impl.dart';
import 'package:e_fashion_flutter/features/home/cubit/home_cubit.dart';
import 'package:e_fashion_flutter/features/home/repos/home_repo.dart';
import 'package:e_fashion_flutter/features/home/repos/home_repo_impl.dart';
import 'package:e_fashion_flutter/features/profile/cubit/map_cubit.dart';
import 'package:e_fashion_flutter/features/profile/cubit/user_cubit.dart';
import 'package:e_fashion_flutter/features/profile/repos/map_repo.dart';
import 'package:e_fashion_flutter/features/profile/repos/map_repo_impl.dart';
import 'package:e_fashion_flutter/features/profile/repos/user_repo.dart';
import 'package:e_fashion_flutter/features/profile/repos/user_repo_impl.dart';
import 'package:e_fashion_flutter/features/search/cubit/search_cubit.dart';
import 'package:e_fashion_flutter/features/search/repo/search_repo.dart';
import 'package:e_fashion_flutter/shared/app_cubit/app_cubit.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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
    getIt.registerLazySingleton<FcmHelper>(() => FcmHelper());
    getIt.registerLazySingleton<FlutterSecureStorage>(
      () => const FlutterSecureStorage(),
    );
    getIt.registerLazySingleton<CacheHelper>(() => CacheHelper());
    getIt.registerLazySingleton<DioHelper>(() => DioHelper());
    getIt.registerLazySingleton<AuthRepo>(() => AuthRepoImpl());
    getIt.registerFactory<AuthCubit>(() => AuthCubit(getIt<AuthRepo>()));
    getIt.registerLazySingleton<UserRepo>(() => UserRepoImpl());
    getIt.registerFactory<UserCubit>(
      () => UserCubit(userRepo: getIt<UserRepo>()),
    );
    getIt.registerLazySingleton<LocationService>(() => LocationService());
    getIt.registerLazySingleton<MapRepo>(() => MapRepoImpl());
    getIt.registerFactory<MapCubit>(() => MapCubit(mapRepo: getIt<MapRepo>()));
    getIt.registerLazySingleton<HomeRepo>(() => HomeRepoImpl());
    getIt.registerFactory<HomeCubit>(
      () => HomeCubit(homeRepo: getIt<HomeRepo>()),
    );
    getIt.registerLazySingleton<SearchRepo>(() => SearchRepo());
    getIt.registerFactory<SearchCubit>(
      () => SearchCubit(searchRepo: getIt<SearchRepo>()),
    );
    getIt.registerFactory<AppCubit>(() => AppCubit());
  }
}
