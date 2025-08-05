import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/features/cart/data/cart_model.dart';
import 'package:equatable/equatable.dart';

class CartState extends Equatable {
  final RequestStatus cartState;
  final String cartErrorMessage;
  final List<CartModel> cartItems;
  final RequestStatus changeQuantityState;

  final Map<String, CartModel> cartMap;

  const CartState({
    this.cartState = RequestStatus.initial,
    this.cartErrorMessage = '',
    this.cartItems = const [],
    this.changeQuantityState = RequestStatus.initial,
    this.cartMap = const {},
  });

  num get totalPrice =>
      cartMap.values.fold(0, (sum, item) => sum + item.totalPrice);

  CartState copyWith({
    RequestStatus? cartState,
    String? cartErrorMessage,
    List<CartModel>? cartItems,
    changeQuantityState,
    Map<String, CartModel>? cartMap,
  }) {
    return CartState(
      cartState: cartState ?? this.cartState,
      cartErrorMessage: cartErrorMessage ?? this.cartErrorMessage,
      cartItems: cartItems ?? this.cartItems,
      changeQuantityState: changeQuantityState ?? this.changeQuantityState,
      cartMap: cartMap ?? this.cartMap,
    );
  }

  @override
  List<Object> get props => [
    cartState,
    cartErrorMessage,
    cartItems,
    changeQuantityState,
    cartMap,
  ];
}
