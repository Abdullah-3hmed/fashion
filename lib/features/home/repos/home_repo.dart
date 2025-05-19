import 'package:dartz/dartz.dart';
import 'package:e_fashion_flutter/core/error/failures.dart';
import 'package:e_fashion_flutter/features/home/data/category_model.dart';
import 'package:e_fashion_flutter/features/home/data/collection_details_model.dart';
import 'package:e_fashion_flutter/features/home/data/collection_model.dart';
import 'package:e_fashion_flutter/features/home/data/offer_model.dart';
import 'package:e_fashion_flutter/features/home/data/product_details_model.dart';
import 'package:e_fashion_flutter/features/home/data/product_model.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<CollectionModel>>> getCollections();

  Future<Either<Failure, List<CategoryModel>>> getCategories();

  Future<Either<Failure, CollectionDetailsModel>> getCollectionDetails({
    required int collectionId,
    required int price,
  });

  Future<Either<Failure, List<OfferModel>>> getOffers();

  Future<Either<Failure, ProductDetailsModel>> getProductDetails({
    required int productId,
  });

  Future<Either<Failure, List<ProductModel>>> getProducts({
    required int? categoryId,
    required String? gender,
  });
}
