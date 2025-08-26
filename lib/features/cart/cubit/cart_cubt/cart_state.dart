import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/features/cart/data/cart/cart_model.dart';
import 'package:equatable/equatable.dart';

class CartState extends Equatable {
  final RequestStatus cartState;
  final String cartErrorMessage;
  final RequestStatus changeQuantityState;
  final Map<String, CartModel> cartMap;
final bool isFirstLoad;
  const CartState({
    this.cartState = RequestStatus.initial,
    this.cartErrorMessage = '',
    this.changeQuantityState = RequestStatus.initial,
    this.cartMap = const {},
    this.isFirstLoad = true,
  });

  num get totalPrice =>
      cartMap.values.fold(0, (sum, item) => sum + item.totalPrice);

  CartState copyWith({
    RequestStatus? cartState,
    String? cartErrorMessage,
    changeQuantityState,
    Map<String, CartModel>? cartMap,
    bool? isFirstLoad,
  }) {
    return CartState(
      cartState: cartState ?? this.cartState,
      cartErrorMessage: cartErrorMessage ?? this.cartErrorMessage,
      changeQuantityState: changeQuantityState ?? this.changeQuantityState,
      cartMap: cartMap ?? this.cartMap,
      isFirstLoad: isFirstLoad ?? this.isFirstLoad,
    );
  }

  @override
  List<Object> get props => [
    cartState,
    cartErrorMessage,
    changeQuantityState,
    cartMap,
    isFirstLoad,
  ];
}
