import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/features/cart/cubit/payment_cubit/payment_state.dart';
import 'package:e_fashion_flutter/features/cart/data/payment/payment_request_model.dart';
import 'package:e_fashion_flutter/features/cart/repo/payment_repo/payment_repo.dart';
import 'package:e_fashion_flutter/features/cart/repo/payment_repo/payment_repo_impl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentCubit extends Cubit<PaymentState> {
  final PaymentRepo paymentRepo;

  PaymentCubit({required this.paymentRepo}) : super(const PaymentState());

  Future<void> payWithPaymobCart({
    required PaymentRequestModel paymentModel,
  }) async {
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
      (paymentResponseModel) {
        emit(
          state.copyWith(
            paymentState: RequestStatus.success,
            paymentResponseModel: paymentResponseModel,
          ),
        );
      },
    );
  }

  Future<void> getPaymentStatus({required int orderId}) async {
    emit(state.copyWith(getPaymentStatus: RequestStatus.loading));
    final result = await paymentRepo.getPaymentStatus(orderId: orderId);
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            getPaymentStatus: RequestStatus.error,
            getPaymentStatusErrorMessage: failure.errorMessage,
          ),
        );
      },
      (paymentSuccessModel) {
        emit(
          state.copyWith(
            getPaymentStatus: RequestStatus.success,
            paymentSuccessModel: paymentSuccessModel,
          ),
        );
      },
    );
  }
}
