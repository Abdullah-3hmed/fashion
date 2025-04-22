import 'package:dartz/dartz.dart';
import 'package:e_fashion_flutter/core/error/failures.dart';

abstract class AuthRepo {
  Future<Either<Failure, int>> userLogin();
}
