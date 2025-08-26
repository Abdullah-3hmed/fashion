import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:equatable/equatable.dart';

class PaymentState extends Equatable{
  final RequestStatus paymentState;
  final String paymentErrorMessage;
  final String paymentToken;

  const PaymentState({
    this.paymentState = RequestStatus.initial,
    this.paymentErrorMessage = '',
    this.paymentToken = '',
  });

  PaymentState copyWith({
    RequestStatus? paymentState,
    String? paymentErrorMessage,
    String? paymentToken,
  }) {
    return PaymentState(
      paymentState: paymentState ?? this.paymentState,
      paymentErrorMessage: paymentErrorMessage ?? this.paymentErrorMessage,
      paymentToken: paymentToken ?? this.paymentToken,
    );
  }

  @override
  List<Object> get props => [
    paymentState,
    paymentErrorMessage,
    paymentToken,
  ];
}