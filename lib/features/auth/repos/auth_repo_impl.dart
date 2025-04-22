import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_fashion_flutter/core/error/failures.dart';
import 'package:e_fashion_flutter/core/network/network_info.dart';
import 'package:e_fashion_flutter/core/services/service_locator.dart';
import 'package:e_fashion_flutter/features/auth/repos/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  @override
  Future<Either<Failure, int>> userLogin() async {
    if (await getIt<NetworkInfo>().isConnected) {
      try {
        return const Right(200);
      } on DioException catch (e) {
        return left(ServerFailure.fromDioError(e));
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return const Left(ServerFailure('No internet connection'));
    }
  }
}
