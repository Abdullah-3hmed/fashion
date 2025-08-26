import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/features/cart/cubit/cart_cubt/cart_state.dart';
import 'package:e_fashion_flutter/features/cart/data/cart/cart_model.dart';
import 'package:e_fashion_flutter/features/cart/repo/cart_repo/cart_repo.dart';
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
        final updatedMap = Map<String, CartModel>.from(state.cartMap)..update(
          cartModel.productId,
          (_) => cartModel,
          ifAbsent: () => cartModel,
        );
        emit(
          state.copyWith(
            cartState: RequestStatus.success,
            isFirstLoad: false,
            cartMap: updatedMap,
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
          cartMap: _generateCartMap(cartItems),
        ),
      ),
    );
  }

  Future<void> incrementQuantity(int quantity, String productId) async {
    final CartModel? updatedItem = state.cartMap[productId]?.copyWith(quantity: quantity);
    if (updatedItem == null) return;

    final updatedMap = Map<String, CartModel>.of(state.cartMap)
      ..[productId] = updatedItem;

    emit(
      state.copyWith(
        cartMap: updatedMap,
      ),
    );

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

  Future<void> decrementQuantity(int quantity, String productId) async {
    final CartModel? updatedItem = state.cartMap[productId]?.copyWith(quantity: quantity);
    if (updatedItem == null) return;

    final updatedMap = Map<String, CartModel>.of(state.cartMap)
      ..[productId] = updatedItem;

    emit(
      state.copyWith(
        cartMap: updatedMap,
      ),
    );

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



  Map<String, CartModel> _generateCartMap(List<CartModel> items) => {
    for (var item in items) item.productId: item,
  };

  Future<void> deleteFromCart({required String productId}) async {
    final previousMap = Map<String, CartModel>.from(state.cartMap);
    final updatedMap = Map<String, CartModel>.from(state.cartMap)
      ..remove(productId);

    emit(state.copyWith(cartMap: updatedMap, cartState: RequestStatus.success));

    final result = await cartRepo.deleteFromCart(productId: productId);

    result.fold((failure) {
      emit(
        state.copyWith(
          cartMap: previousMap,
          cartState: RequestStatus.error,
          cartErrorMessage: failure.errorMessage,
        ),
      );
    }, (_) => null);
  }
}
