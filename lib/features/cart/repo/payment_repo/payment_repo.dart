import 'package:dartz/dartz.dart';
import 'package:e_fashion_flutter/core/error/failures.dart';
import 'package:e_fashion_flutter/features/cart/data/payment/payment_request_model.dart';
import 'package:e_fashion_flutter/features/cart/data/payment/payment_response_model.dart';
import 'package:e_fashion_flutter/features/cart/data/payment/payment_success_model.dart';

abstract class PaymentRepo {
  Future<Either<Failure, PaymentResponseModel>> payWithPaymobCart({
    required PaymentRequestModel paymentModel,
  });

  Future<Either<Failure, PaymentSuccessModel>> getPaymentStatus({
    required int orderId,
  });
}
