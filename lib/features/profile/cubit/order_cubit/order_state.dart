import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/features/profile/data/order/order_model.dart';
import 'package:equatable/equatable.dart';

class OrderState extends Equatable {
  final RequestStatus orderState;
  final List<OrderModel> orders;
  final String orderErrorMessage;

  const OrderState({
     this.orderState = RequestStatus.loading,
     this.orders = const [],
     this.orderErrorMessage= "",
  });

  OrderState copyWith({
    RequestStatus? orderState,
    List<OrderModel>? orders,
    String? orderErrorMessage,
  }) {
    return OrderState(
      orderState: orderState ?? this.orderState,
      orders: orders ?? this.orders,
      orderErrorMessage: orderErrorMessage ?? this.orderErrorMessage,
    );
  }

  @override
  List<Object> get props => [orderState, orders, orderErrorMessage];
}
