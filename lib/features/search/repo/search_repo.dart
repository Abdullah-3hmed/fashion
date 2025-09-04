import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_fashion_flutter/core/error/error_model.dart';
import 'package:e_fashion_flutter/core/error/failures.dart';
import 'package:e_fashion_flutter/core/error/server_exception.dart';
import 'package:e_fashion_flutter/core/network/api_constants.dart';
import 'package:e_fashion_flutter/core/network/dio_helper.dart';
import 'package:e_fashion_flutter/shared/data/product_model.dart';

class SearchRepo {
  final DioHelper dioHelper;

  SearchRepo({required this.dioHelper});

  Future<Either<Failure, List<ProductModel>>> searchProducts({
    required String query,
    required String? brand,
    required int? categoryId,
    required int? minPrice,
    required int? maxPrice,
  }) async {
    try {
      Map<String, dynamic> queryParameters = {"Qurey": query};
      if (brand != null) queryParameters['Brand'] = brand;
      if (categoryId != null) queryParameters['CategoryId'] = categoryId;
      if (minPrice != null) queryParameters['minPrice'] = minPrice;
      if (maxPrice != null) queryParameters['maxPrice'] = maxPrice;

      final response = await dioHelper.get(
        url: ApiConstants.searchEndpoint,
        queryParameters: queryParameters,
      );

      if (response.statusCode == 200) {
        return Right(
          List<ProductModel>.from(
            (response.data["data"] as List? ?? []).map(
                  (x) => ProductModel.fromJson(x),
            ),
          ),
        );
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
