import 'package:dartz/dartz.dart';
import 'package:e_fashion_flutter/core/error/failures.dart';
import 'package:e_fashion_flutter/features/auth/data/sign_up_model.dart';

abstract class AuthRepo {
  Future<Either<Failure, SingUpResponseModel>> userSignUp({
    required SignUpRequestModel signUpRequestModel,
  });
}
