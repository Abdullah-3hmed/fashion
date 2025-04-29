import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_fashion_flutter/core/error/failures.dart';
import 'package:e_fashion_flutter/core/local/cache_helper.dart';
import 'package:e_fashion_flutter/core/network/api_constants.dart';
import 'package:e_fashion_flutter/core/network/dio_helper.dart';
import 'package:e_fashion_flutter/core/services/service_locator.dart';
import 'package:e_fashion_flutter/core/utils/app_constants.dart';
import 'package:e_fashion_flutter/features/profile/data/edit_profile_model.dart';
import 'package:e_fashion_flutter/features/profile/data/user_model.dart';
import 'package:e_fashion_flutter/features/profile/repos/profile_repo.dart';
import 'package:flutter/material.dart';

class ProfileRepoImpl implements ProfileRepo {
  @override
  Future<Either<Failure, UserModel>> getUserProfile() async {
    try {
      debugPrint("Bearer ${AppConstants.token}");
      final response = await getIt<DioHelper>().get(
        url: ApiConstants.getUserProfileEndpoint,
        headers: {"Authorization": "Bearer ${AppConstants.token}"},
      );
      return Right(UserModel.fromJson(response.data));
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logOut({required String email}) async {
    try {
      await getIt<DioHelper>().get(
        url: ApiConstants.logOutEndpoint,
        data: {"email": email},
        headers: {"Authorization": "Bearer ${AppConstants.token}"},
      );
      await getIt<CacheHelper>().delete(key: "token");
      AppConstants.token = "";
      return const Right(null);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, EditProfileModel>> editProfile({
    required EditProfileModel editProfileModel,
  }) async {
    try {
      final response = await getIt<DioHelper>().put(
        url: ApiConstants.editProfileEndpoint,
        data: FormData.fromMap(editProfileModel.toJson()),
        headers: {"Authorization": "Bearer ${AppConstants.token}"},
      );
      return Right(EditProfileModel.fromJson(response.data));
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
