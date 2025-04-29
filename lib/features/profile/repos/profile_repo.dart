import 'package:dartz/dartz.dart';
import 'package:e_fashion_flutter/core/error/failures.dart';
import 'package:e_fashion_flutter/features/profile/data/edit_profile_model.dart';
import 'package:e_fashion_flutter/features/profile/data/user_model.dart';

abstract class ProfileRepo {
  Future<Either<Failure, UserModel>> getUserProfile();
  Future<Either<Failure, void>> logOut({required String email});
  Future<Either<Failure, EditProfileModel>> editProfile({
    required EditProfileModel editProfileModel,
  });
}
