import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_fashion_flutter/core/error/failures.dart';
import 'package:e_fashion_flutter/core/local/cache_helper.dart';
import 'package:e_fashion_flutter/core/network/api_constants.dart';
import 'package:e_fashion_flutter/core/network/dio_helper.dart';
import 'package:e_fashion_flutter/core/services/service_locator.dart';
import 'package:e_fashion_flutter/core/utils/app_constants.dart';
import 'package:e_fashion_flutter/features/profile/data/user_model.dart';
import 'package:e_fashion_flutter/features/profile/repos/profile_repo.dart';

class ProfileRepoImpl implements ProfileRepo {
  @override
  Future<Either<Failure, UserModel>> getUserProfile() async {
    try {
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
}
