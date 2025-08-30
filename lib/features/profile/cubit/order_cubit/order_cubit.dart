import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/features/profile/cubit/order_cubit/order_state.dart';
import 'package:e_fashion_flutter/features/profile/repos/order_repo/order_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderCubit extends Cubit<OrderState> {
  final OrderRepo orderRepo;

  OrderCubit({required this.orderRepo}) : super(const OrderState());

  Future<void> getOrders() async {
    final result = await orderRepo.getOrders();
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            orderState: RequestStatus.error,
            orderErrorMessage: failure.errorMessage,
          ),
        );
      },
      (orders) {
        emit(state.copyWith(orderState: RequestStatus.success, orders: orders));
      },
    );
  }
}
