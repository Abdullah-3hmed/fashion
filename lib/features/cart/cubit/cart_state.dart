import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/features/cart/data/cart_model.dart';
import 'package:equatable/equatable.dart';

class CartState extends Equatable {
  final RequestStatus cartState;
  final String cartErrorMessage;
  final List<CartModel> cartItems;

  const CartState({
    this.cartState = RequestStatus.initial,
    this.cartErrorMessage = '',
    this.cartItems = const [],
  });

  double get totalPrice =>
      cartItems.fold(0.0, (sum, item) => sum + (item.price * item.quantity));

  CartState copyWith({
    RequestStatus? cartState,
    String? cartErrorMessage,
    List<CartModel>? cartItems,
  }) {
    return CartState(
      cartState: cartState ?? this.cartState,
      cartErrorMessage: cartErrorMessage ?? this.cartErrorMessage,
      cartItems: cartItems ?? this.cartItems,
    );
  }

  @override
  List<Object> get props => [cartState, cartErrorMessage, cartItems];
}
