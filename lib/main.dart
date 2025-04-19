import 'package:bloc/bloc.dart';
import 'package:e_fashion_flutter/bloc_observer.dart';
import 'package:e_fashion_flutter/core/network/dio_helper.dart';
import 'package:e_fashion_flutter/core/services/service_locator.dart';
import 'package:e_fashion_flutter/my_app.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ServiceLocator().init();
  DioHelper.init();
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}
