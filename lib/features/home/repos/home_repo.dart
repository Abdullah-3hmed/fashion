import 'package:dartz/dartz.dart';
import 'package:e_fashion_flutter/core/error/failures.dart';
import 'package:e_fashion_flutter/features/home/data/category_model.dart';
import 'package:e_fashion_flutter/features/home/data/collection_details_model.dart';
import 'package:e_fashion_flutter/features/home/data/collection_model.dart';
import 'package:e_fashion_flutter/features/home/data/products_model.dart';
import 'package:e_fashion_flutter/features/home/data/product_details_model.dart';
import 'package:e_fashion_flutter/features/home/data/review_model.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<CollectionModel>>> getCollections();

  Future<Either<Failure, List<CategoryModel>>> getCategories();

  Future<Either<Failure, CollectionDetailsModel>> getCollectionDetails({
    required String collectionId,
  });
  Future<Either<Failure,ProductsModel>> getProducts({required int? gender,required int? category});
}
