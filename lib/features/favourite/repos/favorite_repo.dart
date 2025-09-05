import 'package:dartz/dartz.dart';
import 'package:e_fashion_flutter/core/error/failures.dart';
import 'package:e_fashion_flutter/features/favourite/data/favorite_model.dart';

abstract class FavoriteRepo {
  Future<Either<Failure, void>> addAndRemoveToFavorite({
    required String productId,
  });
  Future<Either<Failure, List<FavoriteModel>>> getFavorites();
}
