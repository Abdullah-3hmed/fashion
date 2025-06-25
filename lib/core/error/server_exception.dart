
import 'package:e_fashion_flutter/core/error/error_model.dart';

class ServerException implements Exception {
  final ErrorModel errorModel;

  const ServerException({required this.errorModel});
}
