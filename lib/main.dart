import 'dart:developer';

import 'package:e_fashion_flutter/bloc_observer.dart';
import 'package:e_fashion_flutter/core/local/cache_helper.dart';
import 'package:e_fashion_flutter/core/network/dio_helper.dart';
import 'package:e_fashion_flutter/core/notifications/fcm_init_helper.dart';
import 'package:e_fashion_flutter/core/services/connection_service.dart';
import 'package:e_fashion_flutter/core/services/service_locator.dart';
import 'package:e_fashion_flutter/core/utils/app_constants.dart';
import 'package:e_fashion_flutter/firebase_options.dart';
import 'package:e_fashion_flutter/my_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: HydratedStorageDirectory(
      (await getTemporaryDirectory()).path,
    ),
  );

  ServiceLocator().init();
  await FcmInitHelper.initAwesomeNotification();
  DioHelper.init();
  final cache = getIt<CacheHelper>();

  final storedToken = await cache.readData(key: "token");
  final storedUserId = await cache.readData(key: "user_id");

  AppConstants.token = storedToken ?? "";
  AppConstants.userId = storedUserId ?? "";

  debugPrint("Init userId: ${AppConstants.userId}");
  debugPrint("Init user token: ${AppConstants.token}");
  Bloc.observer = MyBlocObserver();
  await FcmInitHelper.initFirebaseMessagingListeners();
  await FcmInitHelper.setAwesomeNotificationListeners();
  await FcmInitHelper.handleInitialMessage();
  runApp(const MyApp());
}
