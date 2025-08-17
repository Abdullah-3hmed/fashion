import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_fashion_flutter/core/error/error_model.dart';
import 'package:e_fashion_flutter/core/error/failures.dart';
import 'package:e_fashion_flutter/core/error/server_exception.dart';
import 'package:e_fashion_flutter/core/network/api_constants.dart';
import 'package:e_fashion_flutter/core/network/dio_helper.dart';
import 'package:e_fashion_flutter/core/services/service_locator.dart';
import 'package:e_fashion_flutter/core/utils/app_constants.dart';
import 'package:e_fashion_flutter/features/home/data/home/category_model.dart';
import 'package:e_fashion_flutter/features/home/data/home/collection_details_model.dart';
import 'package:e_fashion_flutter/features/home/data/home/collection_model.dart';
import 'package:e_fashion_flutter/features/home/data/home/products_model.dart';
import 'package:e_fashion_flutter/features/home/data/home_details/review_model.dart';
import 'package:e_fashion_flutter/features/home/repos/home_repo/home_repo.dart';

class HomeRepoImpl implements HomeRepo {
  final DioHelper dioHelper;

  HomeRepoImpl({required this.dioHelper});

  List<CategoryModel> _categories = [];

  @override
  Future<Either<Failure, List<CollectionModel>>> getCollections() async {
    try {
      final response = await dioHelper.get(
        url: ApiConstants.getCollectionsEndpoint,
        headers: {"Authorization": "Bearer ${AppConstants.token}"},
      );
      if (response.statusCode == 200) {
        return Right(
          List<CollectionModel>.from(
            (response.data as List).map(
              (collection) => CollectionModel.fromJson(collection),
            ),
          ),
        );
      }
      throw ServerException(errorModel: ErrorModel.fromJson(response.data));
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorModel.errors.join(" \n")));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CollectionDetailsModel>> getCollectionDetails({
    required String collectionId,
  }) async {
    try {
      final response = await dioHelper.get(
        url: ApiConstants.getCollectionDetailsEndpoint(
          collectionId: collectionId,
        ),
        headers: {"Authorization": "Bearer ${AppConstants.token}"},
      );
      if (response.statusCode == 200) {
        return Right(CollectionDetailsModel.fromJson(response.data));
      }

      throw ServerException(errorModel: ErrorModel.fromJson(response.data));
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorModel.errors.join(" \n")));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CategoryModel>>> getCategories() async {
    try {
      final response = await dioHelper.get(
        url: ApiConstants.getCategoriesEndpoint,
        headers: {"Authorization": "Bearer ${AppConstants.token}"},
      );
      if (response.statusCode == 200) {
        _categories = List<CategoryModel>.from(
          (response.data as List).map(
            (category) => CategoryModel.fromJson(category),
          ),
        );
        return Right(_categories);
      }
      throw ServerException(errorModel: ErrorModel.fromJson(response.data));
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorModel.errors.join(" \n")));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProductsModel>> getProducts({
    required int? gender,
    required int? category,
  }) async {
    Map<String, dynamic> queryParameters = {};
    if (gender != null) {
      queryParameters['ProductType'] = gender;
    }
    if (category != null) {
      queryParameters['CategoryId'] = category;
    }
    try {
      final response = await dioHelper.get(
        url: ApiConstants.getProductsEndPoint,
        headers: {"Authorization": "Bearer ${AppConstants.token}"},
        queryParameters: queryParameters,
      );
      if (response.statusCode == 200) {
        return Right(ProductsModel.fromJson(response.data));
      }
      throw ServerException(errorModel: ErrorModel.fromJson(response.data));
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorModel.errors.join(" \n")));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  List<CategoryModel> getCategoriesList() => List.unmodifiable(_categories);
}
