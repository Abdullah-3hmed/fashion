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
    );
    result.fold(
      (failure) => emit(
        state.copyWith(
          cartState: RequestStatus.error,
          cartErrorMessage: failure.errorMessage,
        ),
      ),
      (success) => emit(
        state.copyWith(
          cartState: RequestStatus.success,
          cartItems: [...state.cartItems, cartModel],
        ),
      ),
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
        state.copyWith(cartState: RequestStatus.success, cartItems: cartItems),
      ),
    );
  }

  Future<void> incrementQuantity(int quantity, String productId) async {
    final cartItems =
        state.cartItems.map((e) {
          if (e.productId == productId) {
            return e.copyWith(quantity:  quantity);
          }
          return e;
        }).toList();
    emit(state.copyWith(cartItems: cartItems));
    final result = await cartRepo.incrementQuantity(productId: productId);
    result.fold(
      (failure) => emit(
        state.copyWith(
          changeQuantityState: RequestStatus.error,
          cartErrorMessage: failure.errorMessage,
        ),
      ),
      (success) => null,
    );
  }

  Future<void> decrementQuantity(int quantity, String productId) async{
    final cartItems =
        state.cartItems.map((e) {
          if (e.productId == productId) {
            return e.copyWith(quantity:quantity);
          }
          return e;
        }).toList();
    emit(state.copyWith(cartItems: cartItems));
    final result = await cartRepo.decrementQuantity(productId: productId);
    result.fold(
      (failure) => emit(
        state.copyWith(
          changeQuantityState: RequestStatus.error,
          cartErrorMessage: failure.errorMessage,
        ),
      ),
      (success) => null,
    );
  }
}
