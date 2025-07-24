import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_fashion_flutter/core/error/error_model.dart';
import 'package:e_fashion_flutter/core/error/failures.dart';
import 'package:e_fashion_flutter/core/error/server_exception.dart';
import 'package:e_fashion_flutter/core/network/api_constants.dart';
import 'package:e_fashion_flutter/core/network/dio_helper.dart';
import 'package:e_fashion_flutter/core/services/service_locator.dart';
import 'package:e_fashion_flutter/features/auth/data/auth_response_model.dart';
import 'package:e_fashion_flutter/features/auth/data/login_request_model.dart';
import 'package:e_fashion_flutter/features/auth/data/reset_password_request_model.dart';
import 'package:e_fashion_flutter/features/auth/data/sign_up_request_model.dart';
import 'package:e_fashion_flutter/features/auth/repos/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final DioHelper dioHelper;

  AuthRepoImpl({required this.dioHelper});

  @override
  Future<Either<Failure, AuthResponseModel>> userSignUp({
    required SignUpRequestModel signUpRequestModel,
  }) async {
    try {
      final response = await dioHelper.post(
        url: ApiConstants.singUpEndpoint,
        data: FormData.fromMap(signUpRequestModel.toJson()),
      );
      if (response.data["statusCode"] == 200) {
        return Right(AuthResponseModel.fromJson(response.data));
      } else {
        throw ServerException(errorModel: ErrorModel.fromJson(response.data));
      }
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorModel.errors.join(" \n")));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthResponseModel>> userLogin({
    required LoginRequestModel loginRequestModel,
  }) async {
    try {
      final response = await dioHelper.post(
        url: ApiConstants.loginEndpoint,
        data: loginRequestModel.toJson(),
      );
      if (response.data["statusCode"] == 200) {
        return Right(AuthResponseModel.fromJson(response.data));
      } else {
        throw ServerException(errorModel: ErrorModel.fromJson(response.data));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorModel.errors.join(" \n")));
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthResponseModel>> forgetPassword({
    required String email,
  }) async {
    try {
      final response = await dioHelper.post(
        url: ApiConstants.forgetPasswordEndpoint,
        data: {"email": email},
      );
      if (response.data["statusCode"] == 200) {
        return Right(AuthResponseModel.fromJson(response.data));
      } else {
        throw ServerException(errorModel: ErrorModel.fromJson(response.data));
      }
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorModel.errors.join(" \n")));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> verifyOtp({
    required String email,
    required String otp,
  }) async {
    try {
      final response = await dioHelper.post(
        url: ApiConstants.verifyOtpEndpoint,
        data: {"email": email, "otp": otp},
      );
      if (response.data["statusCode"] == 200) {
        return Right(response.data["message"]);
      } else {
        throw ServerException(errorModel: ErrorModel.fromJson(response.data));
      }
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorModel.errors.join(" \n")));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> resetPassword({
    required ResetPasswordRequestModel resetPasswordRequestModel,
  }) async {
    try {
      final response = await dioHelper.put(
        url: ApiConstants.resetPasswordEndpoint,
        data: resetPasswordRequestModel.toJson(),
      );
      if (response.data["statusCode"] == 200) {
        return Right(response.data["message"]);
      } else {
        throw ServerException(errorModel: ErrorModel.fromJson(response.data));
      }
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorModel.errors.join(" \n")));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
