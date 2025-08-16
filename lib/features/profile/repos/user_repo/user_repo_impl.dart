import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_fashion_flutter/core/error/error_model.dart';
import 'package:e_fashion_flutter/core/error/failures.dart';
import 'package:e_fashion_flutter/core/error/server_exception.dart';
import 'package:e_fashion_flutter/core/local/cache_helper.dart';
import 'package:e_fashion_flutter/core/network/api_constants.dart';
import 'package:e_fashion_flutter/core/network/dio_helper.dart';
import 'package:e_fashion_flutter/core/services/service_locator.dart';
import 'package:e_fashion_flutter/core/utils/app_constants.dart';
import 'package:e_fashion_flutter/features/profile/data/edit_user_model.dart';
import 'package:e_fashion_flutter/features/profile/data/message_model.dart';
import 'package:e_fashion_flutter/features/profile/data/user_model.dart';
import 'package:e_fashion_flutter/features/profile/data/user_password_model.dart';
import 'package:e_fashion_flutter/features/profile/repos/user_repo/user_repo.dart';
import 'package:flutter/material.dart';

class UserRepoImpl implements UserRepo {
  final DioHelper dioHelper;

  UserRepoImpl({required this.dioHelper});

  @override
  Future<Either<Failure, UserModel>> getUserProfile() async {
    try {
      final response = await dioHelper.get(
        url: ApiConstants.getProfileEndpoint,
        headers: {"Authorization": "Bearer ${AppConstants.token}"},
      );
      if (response.data["statusCode"] == 200) {
        return Right(UserModel.fromJson(response.data["data"]));
      }
      throw ServerException(errorModel: ErrorModel.fromJson(response.data));
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorModel.errors.join(" \n")));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, EditUserModel>> editProfile({
    required EditUserModel editUserModel,
  }) async {
    try {
      final response = await dioHelper.put(
        url: ApiConstants.editProfileEndpoint,
        data: FormData.fromMap(editUserModel.toJson()),
        headers: {"Authorization": "Bearer ${AppConstants.token}"},
      );
      if (response.data["statusCode"] == 200) {
        return Right(EditUserModel.fromJson(response.data["data"]));
      }
      throw ServerException(errorModel: ErrorModel.fromJson(response.data));
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorModel.errors.join(" \n")));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> changePassword({
    required UserPasswordModel passwordModel,
  }) async {
    try {
      final response = await dioHelper.post(
        url: ApiConstants.changePasswordEndpoint,
        data: passwordModel.toJson(),
        headers: {"Authorization": "Bearer ${AppConstants.token}"},
      );
      if (response.data["statusCode"] == 200) {
        return Right(response.data["message"]);
      }
      throw ServerException(errorModel: ErrorModel.fromJson(response.data));
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorModel.errors.join(" \n")));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  // @override
  // Future<Either<Failure, void>> sendMessage({required String message}) async {
  //   try {
  //     final response = await dioHelper.post(
  //       url: ApiConstants.sendMessageEndpoint,
  //       headers: {"Authorization": "Bearer ${AppConstants.token}"},
  //       data: {
  //         "senderUserId": AppConstants.userId,
  //         "receiverUserId": AppConstants.supportId,
  //         "content": message,
  //         "chatId": 0,
  //       },
  //     );
  //     if (response.statusCode == 200) {
  //       return const Right(null);
  //     }
  //     throw ServerException(errorModel: ErrorModel.fromJson(response.data));
  //   } on DioException catch (e) {
  //     return Left(ServerFailure.fromDioError(e));
  //   } on ServerException catch (e) {
  //     return Left(ServerFailure(e.errorModel.errors.join(" \n")));
  //   } catch (e) {
  //     return Left(ServerFailure(e.toString()));
  //   }
  // }
}
