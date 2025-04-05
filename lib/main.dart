import 'package:e_fashion_flutter/core/services/service_locator.dart';
import 'package:e_fashion_flutter/my_app.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ServiceLocator().init();
  runApp(const MyApp());
}
