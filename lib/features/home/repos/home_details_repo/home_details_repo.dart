import 'package:dartz/dartz.dart';
import 'package:e_fashion_flutter/core/error/failures.dart';
import 'package:e_fashion_flutter/features/home/data/home_details/product_details_model.dart';

abstract class HomeDetailsRepo {
  Future<Either<Failure, ProductDetailsModel>> getProductDetails({
    required String productId,
  });
}
