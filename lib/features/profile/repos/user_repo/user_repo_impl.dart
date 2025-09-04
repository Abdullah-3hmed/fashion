import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_fashion_flutter/core/error/error_model.dart';
import 'package:e_fashion_flutter/core/error/failures.dart';
import 'package:e_fashion_flutter/core/error/server_exception.dart';
import 'package:e_fashion_flutter/core/network/api_constants.dart';
import 'package:e_fashion_flutter/core/network/dio_helper.dart';
import 'package:e_fashion_flutter/core/utils/app_constants.dart';
import 'package:e_fashion_flutter/core/utils/safe_api_call.dart';
import 'package:e_fashion_flutter/features/profile/data/user/edit_user_model.dart';
import 'package:e_fashion_flutter/features/profile/data/user/user_model.dart';
import 'package:e_fashion_flutter/features/profile/data/user/user_password_model.dart';
import 'package:e_fashion_flutter/features/profile/repos/user_repo/user_repo.dart';

class UserRepoImpl implements UserRepo {
  final DioHelper dioHelper;

  UserRepoImpl({required this.dioHelper});

  @override
  Future<Either<Failure, UserModel>> getUserProfile() async {
    return safeApiCall<UserModel>(() async {
      final response = await dioHelper.get(
        url: ApiConstants.getProfileEndpoint,
        headers: {"Authorization": "Bearer ${AppConstants.token}"},
      );
      if (response.data["statusCode"] == 200) {
        return UserModel.fromJson(response.data["data"]);
      } else {
        throw ServerException(errorModel: ErrorModel.fromJson(response.data));
      }
    });
  }

  @override
  Future<Either<Failure, EditUserModel>> editProfile({
    required EditUserModel editUserModel,
  }) async {
    return safeApiCall<EditUserModel>(() async {
      final response = await dioHelper.put(
        url: ApiConstants.editProfileEndpoint,
        data: FormData.fromMap(editUserModel.toJson()),
        headers: {"Authorization": "Bearer ${AppConstants.token}"},
      );
      if (response.data["statusCode"] == 200) {
        return EditUserModel.fromJson(response.data["data"]);
      } else {
        throw ServerException(errorModel: ErrorModel.fromJson(response.data));
      }
    });
  }

  @override
  Future<Either<Failure, String>> changePassword({
    required UserPasswordModel passwordModel,
  }) async {
    return safeApiCall<String>(() async {
      final response = await dioHelper.post(
        url: ApiConstants.changePasswordEndpoint,
        data: passwordModel.toJson(),
        headers: {"Authorization": "Bearer ${AppConstants.token}"},
      );
      if (response.data["statusCode"] == 200) {
        return response.data["message"];
      } else {
        throw ServerException(errorModel: ErrorModel.fromJson(response.data));
      }
    });
  }
}
