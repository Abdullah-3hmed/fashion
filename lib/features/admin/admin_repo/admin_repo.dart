import 'package:dartz/dartz.dart';
import 'package:e_fashion_flutter/core/error/failures.dart';

abstract class AdminRepo {
  Future<Either<Failure, void>> getAllChats();
}
