import 'package:bloc/bloc.dart';
import 'package:e_fashion_flutter/bloc_observer.dart';
import 'package:e_fashion_flutter/core/network/dio_helper.dart';
import 'package:e_fashion_flutter/core/notifications/fcm_init_helper.dart';
import 'package:e_fashion_flutter/core/services/service_locator.dart';
import 'package:e_fashion_flutter/firebase_options.dart';
import 'package:e_fashion_flutter/my_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  ServiceLocator().init();
  await FcmInitHelper.initAwesomeNotification();
  // await FcmInitHelper.getDeviceToken();
  await dotenv.load(fileName: "lib/.env");
  DioHelper.init();
  Bloc.observer = MyBlocObserver();

  runApp(const MyApp());
}
