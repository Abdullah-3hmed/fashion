import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/features/cart/data/payment/payment_response_model.dart';
import 'package:e_fashion_flutter/features/cart/data/payment/payment_success_model.dart';
import 'package:equatable/equatable.dart';

class PaymentState extends Equatable {
  final RequestStatus paymentState;
  final String paymentErrorMessage;
  final PaymentResponseModel paymentResponseModel;
  final RequestStatus getPaymentStatus;
  final String getPaymentStatusErrorMessage;
  final PaymentSuccessModel paymentSuccessModel;

  const PaymentState({
    this.paymentState = RequestStatus.initial,
    this.paymentErrorMessage = '',
    this.paymentResponseModel = PaymentResponseModel.empty,
    this.getPaymentStatus = RequestStatus.initial,
    this.getPaymentStatusErrorMessage = '',
    this.paymentSuccessModel = PaymentSuccessModel.empty,
  });

  PaymentState copyWith({
    RequestStatus? paymentState,
    String? paymentErrorMessage,
    PaymentResponseModel? paymentResponseModel,
    RequestStatus? getPaymentStatus,
    String? getPaymentStatusErrorMessage,
    PaymentSuccessModel? paymentSuccessModel,
  }) {
    return PaymentState(
      paymentState: paymentState ?? this.paymentState,
      paymentErrorMessage: paymentErrorMessage ?? this.paymentErrorMessage,
      paymentResponseModel: paymentResponseModel ?? this.paymentResponseModel,
      getPaymentStatus: getPaymentStatus ?? this.getPaymentStatus,
      getPaymentStatusErrorMessage:
          getPaymentStatusErrorMessage ?? this.getPaymentStatusErrorMessage,
      paymentSuccessModel: paymentSuccessModel ?? this.paymentSuccessModel,
    );
  }

  @override
  List<Object> get props => [
    paymentState,
    paymentErrorMessage,
    paymentResponseModel,
    getPaymentStatus,
    getPaymentStatusErrorMessage,
    paymentSuccessModel,
  ];
}
