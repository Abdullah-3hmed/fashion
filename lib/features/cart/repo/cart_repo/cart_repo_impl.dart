import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_fashion_flutter/core/error/error_model.dart';
import 'package:e_fashion_flutter/core/error/failures.dart';
import 'package:e_fashion_flutter/core/error/server_exception.dart';
import 'package:e_fashion_flutter/core/network/api_constants.dart';
import 'package:e_fashion_flutter/core/network/dio_helper.dart';
import 'package:e_fashion_flutter/core/utils/app_constants.dart';
import 'package:e_fashion_flutter/core/utils/safe_api_call.dart';
import 'package:e_fashion_flutter/features/cart/data/cart/cart_model.dart';
import 'package:e_fashion_flutter/features/cart/repo/cart_repo/cart_repo.dart';

class CartRepoImpl implements CartRepo {
  final DioHelper dioHelper;

  CartRepoImpl({required this.dioHelper});

  @override
  Future<Either<Failure, void>> addToCart({
    required String productId,
    required int quantity,
    required String size,
    required String color,
  }) async {
    return safeApiCall<void>(() async {
      final response = await dioHelper.post(
        url: ApiConstants.cartEndPoint,
        data: {
          "productId": productId,
          "quantity": quantity,
          "size": size,
          "color": color,
        },
        headers: {"Authorization": "Bearer ${AppConstants.token}"},
      );
      if (response.statusCode == 200) {
        return;
      } else {
        throw ServerException(errorModel: ErrorModel.fromJson(response.data));
      }
    });
  }

  @override
  Future<Either<Failure, List<CartModel>>> getCartItems() async {
    return safeApiCall<List<CartModel>>(() async {
      final response = await dioHelper.get(
        url: ApiConstants.cartEndPoint,
        headers: {"Authorization": "Bearer ${AppConstants.token}"},
      );
      if (response.statusCode == 200) {
        return List<CartModel>.from(
          (response.data["items"] as List? ?? []).map(
            (cart) => CartModel.fromJson(cart),
          ),
        );
      } else {
        throw ServerException(errorModel: ErrorModel.fromJson(response.data));
      }
    });
  }

  @override
  Future<Either<Failure, void>> decrementQuantity({
    required String productId,
  }) async {
    return safeApiCall<void>(() async {
      final response = await dioHelper.post(
        url: ApiConstants.decrementCartEndPoint(productId: productId),
        headers: {"Authorization": "Bearer ${AppConstants.token}"},
      );
      if (response.statusCode == 200) {
        return;
      } else {
        throw ServerException(errorModel: ErrorModel.fromJson(response.data));
      }
    });
  }

  @override
  Future<Either<Failure, void>> incrementQuantity({
    required String productId,
  }) async {
    return safeApiCall<void>(() async {
      final response = await dioHelper.post(
        url: ApiConstants.incrementCartEndPoint(productId: productId),
        headers: {"Authorization": "Bearer ${AppConstants.token}"},
      );
      if (response.statusCode == 200) {
        return;
      } else {
        throw ServerException(errorModel: ErrorModel.fromJson(response.data));
      }
    });
  }

  @override
  Future<Either<Failure, void>> deleteFromCart({
    required String productId,
  }) async {
    return safeApiCall<void>(() async {
      final response = await dioHelper.delete(
        url: ApiConstants.deleteFromCartEndPoint(productId: productId),
        headers: {"Authorization": "Bearer ${AppConstants.token}"},
      );
      if (response.statusCode == 200) {
        return;
      } else {
        throw ServerException(errorModel: ErrorModel.fromJson(response.data));
      }
    });
  }
}
