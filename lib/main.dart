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
import 'package:flutter_dotenv/flutter_dotenv.dart';
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
  await dotenv.load(fileName: "lib/.env");
  DioHelper.init();
  AppConstants.token = await getIt<CacheHelper>().readData(key: "token") ?? "";
  AppConstants.userId = await getIt<CacheHelper>().readData(key: "user_id") ?? "";
  Bloc.observer = MyBlocObserver();
  await ConnectionsService.initConnection();
  runApp(const MyApp());
}
