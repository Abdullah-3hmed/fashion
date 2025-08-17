import 'package:dartz/dartz.dart';
import 'package:e_fashion_flutter/core/error/failures.dart';
import 'package:e_fashion_flutter/features/home/data/home/category_model.dart';
import 'package:e_fashion_flutter/features/home/data/home/collection_details_model.dart';
import 'package:e_fashion_flutter/features/home/data/home/collection_model.dart';
import 'package:e_fashion_flutter/features/home/data/home/products_model.dart';
import 'package:e_fashion_flutter/features/home/data/home_details/review_model.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<CollectionModel>>> getCollections();

  Future<Either<Failure, List<CategoryModel>>> getCategories();

  Future<Either<Failure, CollectionDetailsModel>> getCollectionDetails({
    required String collectionId,
  });
  Future<Either<Failure,ProductsModel>> getProducts({required int? gender,required int? category});
  List<CategoryModel> getCategoriesList();
}
