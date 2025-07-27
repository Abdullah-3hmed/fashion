import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_fashion_flutter/core/error/failures.dart';
import 'package:e_fashion_flutter/core/network/api_constants.dart';
import 'package:e_fashion_flutter/core/network/dio_helper.dart';
import 'package:e_fashion_flutter/core/services/service_locator.dart';
import 'package:e_fashion_flutter/features/search/data/search_model.dart';

class SearchRepo {
  Future<Either<Failure, List<SearchModel>>> searchProducts({
    required String query,
  }) async {
    try {
      final response = await getIt<DioHelper>().get(
        url:"",
        queryParameters: {"Search": query},
      );
      return Right(
        List<SearchModel>.from(
          (response.data[r'$values'] as List).map(
            (product) => SearchModel.fromJson(product),
          ),
        ),
      );
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
