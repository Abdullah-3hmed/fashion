import 'package:equatable/equatable.dart';

class PaymentResponseModel extends Equatable {
  final String url;
  final int orderId;

  const PaymentResponseModel({required this.url, required this.orderId});

  factory PaymentResponseModel.fromJson(Map<String, dynamic> json) =>
      PaymentResponseModel(
        url: json["paymentGate"] ?? "",
        orderId: json["orderId"] ?? "",
      );
  static const PaymentResponseModel empty = PaymentResponseModel(
    url: "",
    orderId: 0,
  );

  @override
  List<Object> get props => [url, orderId];
}
