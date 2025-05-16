import 'package:dartz/dartz.dart';
import 'package:e_fashion_flutter/core/error/failures.dart';
import 'package:e_fashion_flutter/features/home/data/category_model.dart';
import 'package:e_fashion_flutter/features/home/data/collection_model.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<CollectionModel>>> getCollections();
  Future<Either<Failure, List<CategoryModel>>> getCategories();
}
