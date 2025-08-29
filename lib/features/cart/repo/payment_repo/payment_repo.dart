import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_fashion_flutter/core/error/error_model.dart';
import 'package:e_fashion_flutter/core/error/failures.dart';
import 'package:e_fashion_flutter/core/error/server_exception.dart';
import 'package:e_fashion_flutter/core/network/api_constants.dart';
import 'package:e_fashion_flutter/core/network/dio_helper.dart';
import 'package:e_fashion_flutter/core/utils/app_constants.dart';
import 'package:e_fashion_flutter/features/cart/data/payment/payment_request_model.dart';
import 'package:e_fashion_flutter/features/cart/data/payment/payment_response_model.dart';
import 'package:e_fashion_flutter/features/cart/data/payment/payment_success_model.dart';

class PaymentRepo {
  final DioHelper dioHelper;

  PaymentRepo({required this.dioHelper});

  Future<Either<Failure, PaymentResponseModel>> payWithPaymobCart({
    required PaymentRequestModel paymentModel,
  }) async {
    try {
      final response = await dioHelper.post(
        url: ApiConstants.payWithPaymobEndpoint,
        data: paymentModel.toJson(),
        headers: {"Authorization": "Bearer ${AppConstants.token}"},
      );
      if (response.statusCode == 200) {
        return  Right(PaymentResponseModel.fromJson(response.data));
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
  Future<Either<Failure,PaymentSuccessModel>> getPaymentStatus({required int orderId})async{
    try {
      final response = await dioHelper.post(
        url: ApiConstants.getPaymentStatusEndpoint,
        headers: {"Authorization": "Bearer ${AppConstants.token}"},
        query: {
          "OrderId": orderId,
        }
      );
      if (response.statusCode == 200) {
        return  Right(PaymentSuccessModel.fromJson(response.data));
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
}
