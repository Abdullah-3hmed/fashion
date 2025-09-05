import 'package:dartz/dartz.dart';
import 'package:e_fashion_flutter/core/error/failures.dart';
import 'package:e_fashion_flutter/features/profile/data/user/edit_user_model.dart';
import 'package:e_fashion_flutter/features/profile/data/user/user_model.dart';
import 'package:e_fashion_flutter/features/profile/data/user/user_password_model.dart';

abstract class UserRepo {
  Future<Either<Failure, UserModel>> getUserProfile();

  Future<Either<Failure, EditUserModel>> editProfile({
    required EditUserModel editUserModel,
  });

  Future<Either<Failure, String>> changePassword({
    required UserPasswordModel passwordModel,
  });
}
