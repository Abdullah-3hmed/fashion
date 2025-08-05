import 'package:dartz/dartz.dart';
import 'package:e_fashion_flutter/core/error/failures.dart';
import 'package:e_fashion_flutter/features/cart/data/cart_model.dart';

abstract class CartRepo {
  Future<Either<Failure, void>> addToCart({
    required String productId,
    required int quantity,
    required String size,
    required String color,
  });
  Future<Either<Failure, List<CartModel>>> getCartItems();
  Future<Either<Failure, void>> incrementQuantity({
    required String productId,
  });
  Future<Either<Failure, void>> decrementQuantity({
    required String productId,
  });
  Future<Either<Failure, void>> deleteFromCart({
    required String productId,
  });
}