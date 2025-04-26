import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_fashion_flutter/core/error/failures.dart';
import 'package:e_fashion_flutter/core/network/api_constants.dart';
import 'package:e_fashion_flutter/core/network/dio_helper.dart';
import 'package:e_fashion_flutter/core/network/network_info.dart';
import 'package:e_fashion_flutter/core/services/service_locator.dart';
import 'package:e_fashion_flutter/features/auth/data/auth_response_model.dart';
import 'package:e_fashion_flutter/features/auth/data/login_request_model.dart';
import 'package:e_fashion_flutter/features/auth/data/sign_up_request_model.dart';
import 'package:e_fashion_flutter/features/auth/repos/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  @override
  Future<Either<Failure, AuthResponseModel>> userSignUp({
    required SignUpRequestModel signUpRequestModel,
  }) async {
    if (await getIt<NetworkInfo>().isConnected) {
      try {
        final response = await getIt<DioHelper>().post(
          url: ApiConstants.singUpEndpoint,
          data: signUpRequestModel.toJson(),
        );
        return Right(AuthResponseModel.fromJson(response.data));
      } on DioException catch (e) {
        return Left(ServerFailure.fromDioError(e));
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return const Left(ServerFailure("No internet connection"));
    }
  }

  @override
  Future<Either<Failure, AuthResponseModel>> userLogin({
    required LoginRequestModel loginRequestModel,
  }) async {
    if (await getIt<NetworkInfo>().isConnected) {
      try {
        final response = await getIt<DioHelper>().post(
          url: ApiConstants.loginEndpoint,
          data: loginRequestModel.toJson(),
        );
        return Right(AuthResponseModel.fromJson(response.data));
      } on DioException catch (e) {
        return Left(ServerFailure.fromDioError(e));
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return const Left(ServerFailure("No internet connection"));
    }
  }
}
