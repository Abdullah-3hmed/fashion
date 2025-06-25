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
import 'package:e_fashion_flutter/features/auth/data/password_model.dart';
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
        isFormData: true,
        url: ApiConstants.singUpEndpoint,
        data: signUpRequestModel.toJson(),
      );
      if (response.statusCode == 200) {
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
      if (response.statusCode == 200) {
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
  Future<Either<Failure, PasswordModel>> forgetPassword({
    required String email,
  }) async {
    try {
      final response = await dioHelper.post(
        url: ApiConstants.forgetPasswordEndpoint,
        data: {"email": email},
      );
    if (response.statusCode == 200) {
        return Right(PasswordModel.fromJson(response.data));
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
  Future<Either<Failure, PasswordModel>> resetPasswordOtpVerify({
    required String email,
    required String otp,
  }) async {
    try {
      final response = await dioHelper.post(
        url: ApiConstants.resetPasswordOtpVerifyEndpoint,
        data: {"email": email, "otp": otp},
      );
      return Right(PasswordModel.fromJson(response.data));
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> resetPassword({
    required ResetPasswordRequestModel resetPasswordRequestModel,
  }) async {
    try {
      await dioHelper.post(
        url: ApiConstants.resetPasswordEndpoint,
        data: resetPasswordRequestModel.toJson(),
      );
      return const Right(null);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
