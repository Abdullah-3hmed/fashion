import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_fashion_flutter/core/error/failures.dart';
import 'package:e_fashion_flutter/core/error/server_exception.dart';

Future<Either<Failure, T>> safeApiCall<T>(
    Future<T> Function() apiCall) async {
  try {
    final result = await apiCall();
    return Right(result);
  } on DioException catch (e) {
    return Left(ServerFailure.fromDioError(e));
  } on ServerException catch (e) {
    return Left(ServerFailure(e.errorModel.errors.join(" \n")));
  } catch (e) {
    return Left(ServerFailure(e.toString()));
  }
}