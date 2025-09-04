import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_fashion_flutter/core/error/error_model.dart';
import 'package:e_fashion_flutter/core/error/failures.dart';
import 'package:e_fashion_flutter/core/error/server_exception.dart';
import 'package:e_fashion_flutter/core/network/api_constants.dart';
import 'package:e_fashion_flutter/core/network/dio_helper.dart';
import 'package:e_fashion_flutter/core/utils/app_constants.dart';
import 'package:e_fashion_flutter/core/utils/safe_api_call.dart';
import 'package:e_fashion_flutter/features/home/data/home/category_model.dart';
import 'package:e_fashion_flutter/features/home/data/home/collection_details_model.dart';
import 'package:e_fashion_flutter/features/home/data/home/collection_model.dart';
import 'package:e_fashion_flutter/features/home/data/home/offers_model.dart';
import 'package:e_fashion_flutter/features/home/data/home/products_model.dart';
import 'package:e_fashion_flutter/features/home/repos/home_repo/home_repo.dart';

class HomeRepoImpl implements HomeRepo {
  final DioHelper dioHelper;

  HomeRepoImpl({required this.dioHelper});

  List<CategoryModel> _categories = [];

  @override
  Future<Either<Failure, List<CollectionModel>>> getCollections() async {
    return safeApiCall<List<CollectionModel>>(() async {
      final response = await dioHelper.get(
        url: ApiConstants.getCollectionsEndpoint,
        headers: {"Authorization": "Bearer ${AppConstants.token}"},
      );
      if (response.statusCode == 200) {
        return List<CollectionModel>.from(
          (response.data as List).map(
            (collection) => CollectionModel.fromJson(collection),
          ),
        );
      } else {
        throw ServerException(errorModel: ErrorModel.fromJson(response.data));
      }
    });
  }

  @override
  Future<Either<Failure, CollectionDetailsModel>> getCollectionDetails({
    required String collectionId,
  }) async {
    return safeApiCall<CollectionDetailsModel>(() async {
      final response = await dioHelper.get(
        url: ApiConstants.getCollectionDetailsEndpoint(
          collectionId: collectionId,
        ),
        headers: {"Authorization": "Bearer ${AppConstants.token}"},
      );
      if (response.statusCode == 200) {
        return CollectionDetailsModel.fromJson(response.data);
      } else {
        throw ServerException(errorModel: ErrorModel.fromJson(response.data));
      }
    });
  }

  @override
  Future<Either<Failure, List<CategoryModel>>> getCategories() async {
    return safeApiCall<List<CategoryModel>>(() async {
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
        return _categories;
      } else {
        throw ServerException(errorModel: ErrorModel.fromJson(response.data));
      }
    });
  }

  @override
  Future<Either<Failure, ProductsModel>> getProducts({
    required int? gender,
    required int? category,
    int page = 1,
  }) async {
    return safeApiCall<ProductsModel>(() async {
      Map<String, dynamic> queryParameters = {
        "pageIndex": page,
        "pageSize": 20,
      };
      if (gender != null) queryParameters['ProductType'] = gender;
      if (category != null) queryParameters['CategoryId'] = category;

      final response = await dioHelper.get(
        url: ApiConstants.getProductsEndPoint,
        headers: {"Authorization": "Bearer ${AppConstants.token}"},
        queryParameters: queryParameters,
      );
      if (response.statusCode == 200) {
        return ProductsModel.fromJson(response.data);
      } else {
        throw ServerException(errorModel: ErrorModel.fromJson(response.data));
      }
    });
  }

  @override
  Future<Either<Failure, OffersModel>> getOffers({
    required int? gender,
    required int? category,
    int page = 1,
  }) async {
    return safeApiCall<OffersModel>(() async {
      Map<String, dynamic> queryParameters = {
        "pageIndex": page,
        "pageSize": 10,
      };
      if (gender != null) queryParameters['ProductType'] = gender;
      if (category != null) queryParameters['CategoryId'] = category;

      final response = await dioHelper.get(
        url: ApiConstants.getOffersEndPoint,
        headers: {"Authorization": "Bearer ${AppConstants.token}"},
        queryParameters: queryParameters,
      );
      if (response.statusCode == 200) {
        return OffersModel.fromJson(response.data);
      } else {
        throw ServerException(errorModel: ErrorModel.fromJson(response.data));
      }
    });
  }

  @override
  List<CategoryModel> getCategoriesList() => List.unmodifiable(_categories);
}
