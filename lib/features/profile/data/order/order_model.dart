import 'package:equatable/equatable.dart';

class OrderModel extends Equatable {
  final int orderId;
  final num orderPrice;

  const OrderModel({required this.orderId, required this.orderPrice});

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
    orderId: json["transactionId"] ?? 0,
    orderPrice: json["amount"] ?? 0,
  );
  static const OrderModel empty = OrderModel(orderId: 0, orderPrice: 0);

  @override
  List<Object> get props => [orderId, orderPrice];
}
