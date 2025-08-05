import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_fashion_flutter/core/error/error_model.dart';
import 'package:e_fashion_flutter/core/error/failures.dart';
import 'package:e_fashion_flutter/core/error/server_exception.dart';
import 'package:e_fashion_flutter/core/network/api_constants.dart';
import 'package:e_fashion_flutter/core/network/dio_helper.dart';
import 'package:e_fashion_flutter/core/utils/app_constants.dart';
import 'package:e_fashion_flutter/features/cart/data/cart_model.dart';
import 'package:e_fashion_flutter/features/cart/repo/cart_repo.dart';

class CartRepoImpl implements CartRepo {
  final DioHelper dioHelper;

  CartRepoImpl({required this.dioHelper});

  @override
  Future<Either<Failure, void>> addToCart({
    required String productId,
    required int quantity,
    required String size,
  }) async {
    try {
      final response = await dioHelper.post(
        url: ApiConstants.cartEndPoint,
        data: {
          "productId": productId,
          "quantity": quantity,
          "size": size,
        },
        headers: {"Authorization": "Bearer ${AppConstants.token}"},
      );
      if (response.statusCode == 200) {
        return const Right(null);
      } else {
        throw ServerException(errorModel: ErrorModel.fromJson(response.data));
      }
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorModel.errors.join(" \n")));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CartModel>>> getCartItems() async{
   try{
     final response = await dioHelper.get(
       url: ApiConstants.cartEndPoint,
       headers: {"Authorization": "Bearer ${AppConstants.token}"},
     );
     if(response.statusCode == 200){
       return Right(List<CartModel>.from((response.data["items"] as List? ??[]).map((cart) => CartModel.fromJson(cart))));
     }else{
       throw ServerException(errorModel: ErrorModel.fromJson(response.data));
     }
   }on DioException catch (e) {
     return Left(ServerFailure.fromDioError(e));
   } on ServerException catch (e) {
     return Left(ServerFailure(e.errorModel.errors.join(" \n")));
   } catch (e) {
     return Left(ServerFailure(e.toString()));
   }
  }
}
