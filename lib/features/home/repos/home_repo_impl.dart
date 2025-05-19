import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_fashion_flutter/core/error/failures.dart';
import 'package:e_fashion_flutter/core/network/api_constants.dart';
import 'package:e_fashion_flutter/core/network/dio_helper.dart';
import 'package:e_fashion_flutter/core/services/service_locator.dart';
import 'package:e_fashion_flutter/core/utils/app_constants.dart';
import 'package:e_fashion_flutter/features/home/data/category_model.dart';
import 'package:e_fashion_flutter/features/home/data/collection_details_model.dart';
import 'package:e_fashion_flutter/features/home/data/collection_model.dart';
import 'package:e_fashion_flutter/features/home/data/offer_model.dart';
import 'package:e_fashion_flutter/features/home/data/product_details_model.dart';
import 'package:e_fashion_flutter/features/home/data/product_model.dart';
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
          (response.data[r'$values'] as List).map(
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

  @override
  Future<Either<Failure, CollectionDetailsModel>> getCollectionDetails({
    required int collectionId,
    required int price,
  }) async {
    try {
      final response = await getIt<DioHelper>().get(
        url: ApiConstants.getCollectionDetailsEndpoint,
        headers: {"Authorization": "Bearer ${AppConstants.token}"},
        queryParameters: {"id": collectionId, "price": price},
      );
      return Right(CollectionDetailsModel.fromJson(response.data));
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<OfferModel>>> getOffers() async {
    try {
      final response = await getIt<DioHelper>().get(
        url: ApiConstants.getOffersEndpoint,
        headers: {"Authorization": "Bearer ${AppConstants.token}"},
      );
      return Right(
        List<OfferModel>.from(
          (response.data[r'$values'] as List).map(
            (offer) => OfferModel.fromJson(offer),
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
  Future<Either<Failure, ProductDetailsModel>> getProductDetails({
    required int productId,
  }) async {
    try {
      final response = await getIt<DioHelper>().get(
        url: ApiConstants.getProductDetailsEndpoint,
        headers: {"Authorization": "Bearer ${AppConstants.token}"},
        queryParameters: {"id": productId},
      );
      return Right(ProductDetailsModel.fromJson(response.data));
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ProductModel>>> getProducts({
    required int? categoryId,
    required String? gender,
  }) async {
    try {
      Map<String, dynamic> queryParams = {};
      if (categoryId != null) {
        queryParams["categoryId"] = categoryId;
      }
      if (gender != null) {
        queryParams["Gender"] = gender;
      }
      if (gender == null && categoryId == null) {
        queryParams = {"categoryId": categoryId, "Gender": gender};
      }
      final response = await getIt<DioHelper>().get(
        url: ApiConstants.getProductsEndpoint,
        headers: {"Authorization": "Bearer ${AppConstants.token}"},
        queryParameters: queryParams,
      );
      return Right(
        List<ProductModel>.from(
          (response.data[r'$values'] as List).map(
            (product) => ProductModel.fromJson(product),
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
  Future<Either<Failure, void>> addReview({
    required String review,
    required int productId,
    required int rating,
  }) async {
    try {
      await getIt<DioHelper>().post(
        url: ApiConstants.addReviewEndpoint,
        headers: {"Authorization": "Bearer ${AppConstants.token}"},
        data: {"comment": review, "rating": rating, "productId": productId},
      );
      return const Right(null);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
