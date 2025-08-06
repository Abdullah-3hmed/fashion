import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_fashion_flutter/core/error/error_model.dart';
import 'package:e_fashion_flutter/core/error/failures.dart';
import 'package:e_fashion_flutter/core/error/server_exception.dart';
import 'package:e_fashion_flutter/core/network/api_constants.dart';
import 'package:e_fashion_flutter/core/network/dio_helper.dart';
import 'package:e_fashion_flutter/core/utils/app_constants.dart';
import 'package:e_fashion_flutter/features/home/data/home_details/product_details_model.dart';
import 'package:e_fashion_flutter/features/home/data/home_details/review_model.dart';
import 'package:e_fashion_flutter/features/home/repos/home_details_repo/home_details_repo.dart';

class HomeDetailsRepoImpl implements HomeDetailsRepo {
  final DioHelper dioHelper;

  HomeDetailsRepoImpl({required this.dioHelper});

  @override
  Future<Either<Failure, ProductDetailsModel>> getProductDetails({
    required String productId,
  }) async {
    try {
      final response = await dioHelper.get(
        url: ApiConstants.getProductDetailsEndpoint(productId: productId),
        headers: {"Authorization": "Bearer ${AppConstants.token}"},
      );
      if (response.statusCode == 200) {
        return Right(ProductDetailsModel.fromJson(response.data));
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
  Future<Either<Failure, ReviewModel>> addReview({
    required String productId,
    required String review,
    required int rate,
  }) async {
    try {
      final response = await dioHelper.post(
        url: ApiConstants.addReviewEndpoint,
        headers: {"Authorization": "Bearer ${AppConstants.token}"},
        data: {
          "productId": productId,
          "comment": review,
          "rate": rate,
          "review": review,
        },
      );
      if (response.statusCode == 200) {
        return Right(ReviewModel.fromJson(response.data));
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
