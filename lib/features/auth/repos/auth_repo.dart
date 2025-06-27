import 'package:dartz/dartz.dart';
import 'package:e_fashion_flutter/core/error/failures.dart';
import 'package:e_fashion_flutter/features/auth/data/auth_response_model.dart';
import 'package:e_fashion_flutter/features/auth/data/login_request_model.dart';
import 'package:e_fashion_flutter/features/auth/data/reset_password_request_model.dart';
import 'package:e_fashion_flutter/features/auth/data/sign_up_request_model.dart';

abstract class AuthRepo {
  Future<Either<Failure, AuthResponseModel>> userSignUp({
    required SignUpRequestModel signUpRequestModel,
  });
  Future<Either<Failure, AuthResponseModel>> userLogin({
    required LoginRequestModel loginRequestModel,
  });
  Future<Either<Failure, AuthResponseModel>> forgetPassword({
    required String email,
  });
  Future<Either<Failure, String>> verifyOtp({
    required String email,
    required String otp,
  });
  Future<Either<Failure, String>> resetPassword({
    required ResetPasswordRequestModel resetPasswordRequestModel,
  });
}
