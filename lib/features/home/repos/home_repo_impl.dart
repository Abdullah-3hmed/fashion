import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_fashion_flutter/core/error/failures.dart';
import 'package:e_fashion_flutter/core/network/api_constants.dart';
import 'package:e_fashion_flutter/core/network/dio_helper.dart';
import 'package:e_fashion_flutter/core/services/service_locator.dart';
import 'package:e_fashion_flutter/core/utils/app_constants.dart';
import 'package:e_fashion_flutter/features/home/data/category_model.dart';
import 'package:e_fashion_flutter/features/home/data/collection_model.dart';
import 'package:e_fashion_flutter/features/home/repos/home_repo.dart';

class HomeRepoImpl implements HomeRepo {
  @override
  Future<Either<Failure, List<CollectionModel>>> getCollections() async {
    try {
      final response = await getIt<DioHelper>().get(
        url: ApiConstants.getCollectionsEndpoint,
        headers: {"Authorization": "Bearer ${AppConstants.token}"},
      );
      return Right(
        List<CollectionModel>.from(
          (response.data['\$values'] as List).map(
            (collection) => CollectionModel.fromJson(collection),
          ),
        ),
      );
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CategoryModel>>> getCategories() async {
    try {
      final response = await getIt<DioHelper>().get(
        url: ApiConstants.getCategoriesEndpoint,
        headers: {"Authorization": "Bearer ${AppConstants.token}"},
      );
      return Right(
        List<CategoryModel>.from(
          (response.data['\$values'] as List).map(
            (collection) => CategoryModel.fromJson(collection),
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
