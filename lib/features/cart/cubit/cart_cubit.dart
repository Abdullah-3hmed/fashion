import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/features/cart/cubit/cart_state.dart';
import 'package:e_fashion_flutter/features/cart/data/cart_model.dart';
import 'package:e_fashion_flutter/features/cart/repo/cart_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepo cartRepo;

  CartCubit({required this.cartRepo}) : super(const CartState());

  Future<void> addToCart({required CartModel cartModel}) async {
    emit(state.copyWith(cartState: RequestStatus.loading));
    final result = await cartRepo.addToCart(
      productId: cartModel.productId,
      quantity: cartModel.quantity,
      size: cartModel.size,
      color: cartModel.color,
    );
    result.fold(
      (failure) => emit(
        state.copyWith(
          cartState: RequestStatus.error,
          cartErrorMessage: failure.errorMessage,
        ),
      ),
      (_) {
        final List<CartModel> updatedItems = [...state.cartItems, cartModel];
        emit(
          state.copyWith(
            cartState: RequestStatus.success,
            cartItems: updatedItems,
            cartMap: _generateCartMap(updatedItems),
          ),
        );
      },
    );
  }

  Future<void> getCartItems() async {
    emit(state.copyWith(cartState: RequestStatus.loading));
    final result = await cartRepo.getCartItems();
    result.fold(
      (failure) => emit(
        state.copyWith(
          cartState: RequestStatus.error,
          cartErrorMessage: failure.errorMessage,
        ),
      ),
      (cartItems) => emit(
        state.copyWith(
          cartState: RequestStatus.success,
          cartItems: cartItems,
          cartMap: _generateCartMap(cartItems),
        ),
      ),
    );
  }

  Future<void> incrementQuantity(int quantity, String productId) async {
    final updatedItem = state.cartMap[productId]?.copyWith(quantity: quantity);
    if (updatedItem == null) return;

    final updatedMap = Map<String, CartModel>.from(state.cartMap)
      ..update(productId, (_) => updatedItem);

    emit(state.copyWith(cartMap: updatedMap));

    final result = await cartRepo.incrementQuantity(productId: productId);
    result.fold(
          (failure) => emit(state.copyWith(
        changeQuantityState: RequestStatus.error,
        cartErrorMessage: failure.errorMessage,
      )),
          (success) => null,
    );
  }


  Future<void> decrementQuantity(int quantity, String productId) async {
    final updatedItem = state.cartMap[productId]?.copyWith(quantity: quantity);
    if (updatedItem == null) return;

    final updatedMap = Map<String, CartModel>.from(state.cartMap)
      ..update(productId, (_) => updatedItem);

    emit(state.copyWith(cartMap: updatedMap));

    final result = await cartRepo.decrementQuantity(productId: productId);
    result.fold(
          (failure) => emit(state.copyWith(
        changeQuantityState: RequestStatus.error,
        cartErrorMessage: failure.errorMessage,
      )),
          (success) => null,
    );
  }


  Map<String, CartModel> _generateCartMap(List<CartModel> items) => {
    for (var item in items) item.productId: item,
  };
}
