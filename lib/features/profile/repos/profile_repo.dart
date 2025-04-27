import 'package:dartz/dartz.dart';
import 'package:e_fashion_flutter/core/error/failures.dart';
import 'package:e_fashion_flutter/features/profile/data/user_model.dart';

abstract class ProfileRepo {
  Future<Either<Failure, UserModel>> getUserProfile();
  Future<Either<Failure, void>> logOut({required String email});
}
