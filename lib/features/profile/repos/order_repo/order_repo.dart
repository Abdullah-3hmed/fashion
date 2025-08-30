import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_fashion_flutter/core/error/error_model.dart';
import 'package:e_fashion_flutter/core/error/failures.dart';
import 'package:e_fashion_flutter/core/error/server_exception.dart';
import 'package:e_fashion_flutter/core/network/api_constants.dart';
import 'package:e_fashion_flutter/core/network/dio_helper.dart';
import 'package:e_fashion_flutter/core/utils/app_constants.dart';
import 'package:e_fashion_flutter/features/profile/data/order/order_model.dart';

class OrderRepo {
  final DioHelper dioHelper;
  OrderRepo({required this.dioHelper});
  Future<Either<Failure,List<OrderModel>>> getOrders() async {
    try {
      final response = await dioHelper.get(
        url: ApiConstants.getOrdersEndpoint,
        headers: {"Authorization": "Bearer ${AppConstants.token}"},
      );
      if (response.statusCode == 200) {
        return Right(
          List<OrderModel>.from(
            (response.data["result"] as List? ?? []).map(
              (order) => OrderModel.fromJson(order),
            ),
          ),
        );
      } else {
        throw ServerException(errorModel: ErrorModel.fromJson(response.data));
      }
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}