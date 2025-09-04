import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_fashion_flutter/core/error/error_model.dart';
import 'package:e_fashion_flutter/core/error/failures.dart';
import 'package:e_fashion_flutter/core/error/server_exception.dart';
import 'package:e_fashion_flutter/core/network/api_constants.dart';
import 'package:e_fashion_flutter/core/network/dio_helper.dart';
import 'package:e_fashion_flutter/core/utils/app_constants.dart';
import 'package:e_fashion_flutter/core/utils/safe_api_call.dart';
import 'package:e_fashion_flutter/features/cart/data/payment/payment_request_model.dart';
import 'package:e_fashion_flutter/features/cart/data/payment/payment_response_model.dart';
import 'package:e_fashion_flutter/features/cart/data/payment/payment_success_model.dart';
import 'package:e_fashion_flutter/features/cart/repo/payment_repo/payment_repo.dart';

class PaymentRepoImpl implements PaymentRepo {
  final DioHelper dioHelper;

  PaymentRepoImpl({required this.dioHelper});

  @override
  Future<Either<Failure, PaymentResponseModel>> payWithPaymobCart({
    required PaymentRequestModel paymentModel,
  }) async {
    return safeApiCall<PaymentResponseModel>(() async {
      final response = await dioHelper.post(
        url: ApiConstants.payWithPaymobEndpoint,
        data: paymentModel.toJson(),
        headers: {"Authorization": "Bearer ${AppConstants.token}"},
      );
      if (response.statusCode == 200) {
        return PaymentResponseModel.fromJson(response.data);
      } else {
        throw ServerException(errorModel: ErrorModel.fromJson(response.data));
      }
    });
  }

  @override
  Future<Either<Failure, PaymentSuccessModel>> getPaymentStatus({
    required int orderId,
  }) async {
    return safeApiCall<PaymentSuccessModel>(() async {
      final response = await dioHelper.post(
        url: ApiConstants.getPaymentStatusEndpoint,
        headers: {"Authorization": "Bearer ${AppConstants.token}"},
        query: {"OrderId": orderId},
      );
      if (response.statusCode == 200) {
        return PaymentSuccessModel.fromJson(response.data);
      } else {
        throw ServerException(errorModel: ErrorModel.fromJson(response.data));
      }
    });
  }
}
