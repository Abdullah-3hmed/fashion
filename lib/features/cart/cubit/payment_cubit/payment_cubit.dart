import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/features/cart/cubit/payment_cubit/payment_state.dart';
import 'package:e_fashion_flutter/features/cart/data/payment/payment_model.dart';
import 'package:e_fashion_flutter/features/cart/repo/payment_repo/payment_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentCubit extends Cubit<PaymentState> {
  final PaymentRepo paymentRepo;

  PaymentCubit({required this.paymentRepo}) : super(const PaymentState());

  Future<void> payWithPaymobCart({required PaymentModel paymentModel}) async {
    emit(state.copyWith(paymentState: RequestStatus.loading));
    final result = await paymentRepo.payWithPaymobCart(
      paymentModel: paymentModel,
    );
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            paymentState: RequestStatus.error,
            paymentErrorMessage: failure.errorMessage,
          ),
        );
      },
      (paymentToken) {
        emit(
          state.copyWith(
            paymentState: RequestStatus.success,
            paymentToken: paymentToken,
          ),
        );
      },
    );
  }
}
